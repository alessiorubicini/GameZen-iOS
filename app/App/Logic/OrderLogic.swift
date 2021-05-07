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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import SwiftUI
import SwiftUIComponents
import Alamofire

extension AppState {
    
    func loadOrders() {
        
        
        
    }
    
    func makeOrder(addressID: Int, total: Double, products: [Product]) {
        
        // Generate order date
        let orderDate = formatter.string(from: Date())
        
        // Generate estimate delivery date
        let deliveryEstimate = formatter.string(from: Calendar.current.date(byAdding: .day, value: 6, to: Date())!)
        
        // Form a dictionary for posting data
        let body: [String:Any] = ["userID": UserDefaults.standard.integer(forKey: "userID"), "data": orderDate, "delivery": deliveryEstimate, "address": addressID, "total": total, "products": products.map{$0.id}]
        
        // Send order to database through API
        AF.request(API.postOrder.rawValue, method: .post, parameters: body)
            .response { response in
                
                debugPrint(response)
                
                if let statusCode = response.response?.statusCode {
                    
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                        // Show alert
                        self.alert = (true, "Ordine inviato con successo", "Controlla la sezione Ordini nel tuo profilo")
                        
                        // Remove products from cart
                        self.cartManager.products = []
                        
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
    
    func cancelOrder() {
        
    }
    
}
