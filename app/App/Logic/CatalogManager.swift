// CatalogManager.swift
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
import Alamofire

class CatalogManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    
    init() {
        self.loadCategories()
        self.loadAllProducts()
    }
    
    // MARK: - Methods
    
    func loadAllProducts() {
        
        // Send a GET request
        AF.request(API.getAllProducts.rawValue, method: .get)
            .response { response in
                
                if let statusCode = response.response?.statusCode {
                    if statusCode == 200 {
                        do {
                            // Parse user info as JSON to Swift struct
                            let products = try JSONDecoder().decode([Product].self, from: response.data!)
                            
                            self.products = products
                            
                        } catch {
                            
                            
                            
                        }
                    }
                }
                
                
            }
        
    }
    
    
    func loadCategories() {
        
        // Send a GET request
        AF.request(API.getCategories.rawValue, method: .get)
            .response { response in
                
                if let statusCode = response.response?.statusCode {
                    if statusCode == 200 {
                        do {
                            // Parse user info as JSON to Swift struct
                            let categories = try JSONDecoder().decode([Category].self, from: response.data!)
                            
                            self.categories = categories
                            
                        } catch {
                            
                            
                            
                        }
                    }
                }
                
                
            }
        
    }
    
    
}
