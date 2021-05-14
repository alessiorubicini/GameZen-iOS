// AppState.swift
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
import Alamofire
import CryptoKit

// Identifies the app state and manages all the data
class AppState: ObservableObject {
    
    // User account properties
    @Published var user: User? = nil
    @Published var showRegistrationSheet = false
    @Published var isLogged: Bool = false
    @Published var alert = (false, "", "")
    
    @Published var cartManager: CartManager
    @Published var catalogManager: CatalogManager
    
    init() {
        
        self.cartManager = CartManager()
        self.catalogManager = CatalogManager()
        
        // Check if "keepConnected" flag is true
        if UserDefaults.standard.bool(forKey: "keepConnected") == true {
            
            // Get user's credentials from User Defaults local storage
            let email = UserDefaults.standard.string(forKey: "email") ?? "-"
            let password = UserDefaults.standard.string(forKey: "password") ?? "-"
            
            self.login(email: email, password: password)
        }
        
    }
    
        
}
