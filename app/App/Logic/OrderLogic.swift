// OrderLogic.swift
// Copyright (C) 2021 Alessio Rubicini.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import Foundation
import SwiftUI
import SwiftUIComponents
import Alamofire

// Extends the AppState object for orders logic
extension AppState {
    
    func loadOrders() {
        
        self.user!.orders = []
        
        AF.request(API.getOrders.rawValue + "?userID=\(UserDefaults.standard.integer(forKey: "userID"))", method: .get)
            .response { response in
                
                do {
                    
                    // Parse user info as JSON to Swift struct
                    let orders = try JSONDecoder().decode([Order].self, from: response.data!)
                    
                    // Generate success haptic feedback
                    HapticGenerator().notificationFeedback(type: .success)
                    
                    // Update user's orders
                    self.user!.orders = orders
                    
                    print("Ordini ricaricati")
                    
                } catch {
                    
                    // Generate error haptic feedback
                    HapticGenerator().notificationFeedback(type: .error)
                    
                    // Show an alert
                    self.alert = (true, "Errore nel caricamento degli ordini", error.localizedDescription)
                    
                }
            }
        
    }
    
    /// Send a new order to the shop database through APIs
    /// - Parameters:
    ///   - addressID: delivery address ID
    ///   - total: total price of the order
    ///   - products: array of products contained in the order
    func makeOrder(addressID: Int, total: Double, products: [Product]) {
        
        // Generate the order date
        let orderDate = formatter.string(from: Date())
        
        // Generate the estimate delivery date
        let deliveryEstimate = formatter.string(from: Calendar.current.date(byAdding: .day, value: 6, to: Date())!)
        
        // Form a dictionary for posting data
        let body: [String:Any] = ["userID": UserDefaults.standard.integer(forKey: "userID"), "date": orderDate, "delivery": deliveryEstimate, "address": addressID, "total": total, "products": products.map{$0.id}]
        
        // Send order to database through API
        AF.request(API.postOrder.rawValue, method: .post, parameters: body)
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the request has been completed successfully
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                        // Remove products from cart
                        withAnimation {
                            self.cartManager.removeAll()
                        }
                        
                        // Show alert
                        showStatusAlert(icon: "checkmark", title: "Ordine inviato", message: "Controlla la sezione Ordini nel tuo profilo")
                        
                        // Reload user orders
                        self.loadOrders()
                        
                    } else {
                        
                        // Generate error haptic feedback
                        HapticGenerator().notificationFeedback(type: .error)
                        
                        // Display an alert
                        self.alert = (true, "Errore nell'invio dell'ordine", String(data: response.data!, encoding: .utf8)!)
                        
                    }
                    
                }
                
            }
        
    }
    
    /// Cancel an order
    /// - Parameter id: order's id
    func cancelOrder(of id: Int) {
        
        // Remove order from database
        AF.request(API.cancelOrder.rawValue + "?orderID=\(id)", method: .get)
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the request has been completed successfully
                    if statusCode == 200 {
                        
                        // Reload user's orders
                        self.loadOrders()
                        
                        // Display an alert
                        showStatusAlert(icon: "xmark.square.fill", title: "Annullato", message: "Ordine annullato con successo")
                        
                    } else {
                        
                        // Display an alert
                        self.alert = (true, "Errore nell'annullamento dell'ordine", String(data: response.data!, encoding: .utf8)!)
                        
                    }
                    
                }
                
            }
        
    }
    
}
