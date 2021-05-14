// CartManager.swift
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

// This object is responsible of managing the user's cart
class CartManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var products: [Product] = []
    
    // Computed property: represents the total cart price
    var totalPrice: Double {
        var sum: Double = 0.0
        
        for product in self.products {
            sum = sum + product.price
        }
        
        return sum
    }
    
    init() { }
    
    // MARK: - Methods
    
    /// Get the user cart from database thorugh APIs
    func getUserCart() {
        
        // Send a GET request
        AF.request(API.getCart.rawValue + "?userID=\(UserDefaults.standard.integer(forKey: "userID"))", method: .get)
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the response has been completed succesfully
                    if statusCode == 200 {
                        
                        // Try to parse received products as Product struct
                        do {
                            // Parse user info as JSON to Swift struct
                            let products = try JSONDecoder().decode([Product].self, from: response.data!)
                            
                            // Update products array
                            self.products = products
                            
                        } catch {
                            
                            print("ERROR while fetching user's cart")
                            fatalError(error.localizedDescription)
                            
                        }
                    }
                }
                
                
            }
        
    }
    
    /// Add a product to the user's cart
    /// - Parameter product: the product to be added
    func addProduct(product: Product) -> Bool {
        
        // Check if the product was already to the cart
        if self.products.contains(where: {$0.name == product.name}) {
            return false
        }
        
        // Add product to local data
        self.products.append(product)
        
        // Add product to user's cart in database through APIs
        AF.request(API.addProductToCart.rawValue, method: .post, parameters: ["userID": UserDefaults.standard.integer(forKey: "userID"), "productID": product.id])
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the response has been completed succesfully
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                        // Display an alert
                        showStatusAlert(icon: "cart.fill.badge.plus", title: "Aggiunto", message: "Articolo aggiunto al carrello")
                        
                    } else {
                        
                        // Generate error haptic feedback
                        HapticGenerator().notificationFeedback(type: .error)
                        
                    }
                    
                }
                
            }
        
        return true
        
    }
    
    /// Remove a specific product from user's cart
    func removeProduct(at offsets: IndexSet) {

        // Set a default value
        var productID = 0
        
        // Get the product ID from SwiftUI list through offsets
        for index in offsets {
            productID = self.products[index].id
        }
        
        // Remove product from local data
        self.products.remove(atOffsets: offsets)
        
        // Remove from database
        AF.request(API.deleteProductFromCart.rawValue, method: .post, parameters: ["userID": UserDefaults.standard.integer(forKey: "userID"), "productID": productID])
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the response has been completed succesfully
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                    } else {
                        
                        // Generate error haptic feedback
                        HapticGenerator().notificationFeedback(type: .error)
                        
                    }
                    
                }
                
            }
    }
    
    /// Remove all products from user's cart
    func removeAll() {
        
        // Clear local array
        self.products = []
        
        // Send a GET request
        AF.request(API.clearCart.rawValue + "?userID=\(UserDefaults.standard.integer(forKey: "userID"))", method: .get)
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the response has been completed succesfully
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                    } else {
                        
                        // Generate error haptic feedback
                        HapticGenerator().notificationFeedback(type: .error)
                        
                    }
                    
                }
                
            }
        
    }
    
}
