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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import SwiftUI

// This object is responsible of managing the user's cart
class CartManager: ObservableObject {
    
    @Published var products: [Product] = []
    
    init() {
        #if DEBUG
        self.products.append(Product.mocks[0])
        #else
        
        #endif
    }
    
    var totalPrice: Double {
        var sum: Double = 0.0
        
        for product in self.products {
            sum = sum + product.price
        }
        
        return sum
    }
    
    /// Add a product to the user's cart
    /// - Parameter product: the product to be added
    func addProduct(product: Product) -> Bool {
        
        // Check if the product is already in the cart
        if self.products.contains(where: {$0.name == product.name}) {
            return false
        }
        
        self.products.append(product)
        
        return true
        
    }
    
    func proceedToOrder() {
        
        
        
    }
    
}
