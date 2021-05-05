// AuthenticationLogic.swift
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
import CryptoKit

extension AppState {
    
    func login(email: String, password: String) {
        
        // Generate the password MD5 hash
        var hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!).description.split(separator: ":")[1]
        hashedPassw.remove(at: hashedPassw.startIndex)
        
        print("Email: \(email) - Password: \(hashedPassw)")
        
        // Send the login request to the API
        AF.request(API.login.rawValue, method: .post, parameters: ["email": email, "password": hashedPassw])
            .response { response in
                
                if let statusCode = response.response?.statusCode {
                    if statusCode == 200 {
                      
                        do {
                            // Parse user info as JSON to Swift struct
                            let user = try JSONDecoder().decode(User.self, from: response.data!)
                            
                            // Set the user struct
                            DispatchQueue.main.async {
                                self.isLogged = true
                                self.user = user
                            }
                            
                            // Save user ID
                            UserDefaults.standard.setValue(user.id, forKey: "userID")
                            
                            // Fetch data from API
                            self.catalogManager.loadAllProducts()
                            self.catalogManager.loadCategories()
                            self.cartManager.getUserCart()
                            
                        } catch {
                            print(error)
                        }
                        
                    } else if statusCode == 403 {
                        self.alert = (true, "Credenziali non corrette", "Controlla le credenziali inserite")
                    } else if statusCode == 404 {
                        self.alert = (true, "Utente non trovato", "Controlla le credenziali inserite o registrati al negozio")
                    } else if statusCode == 500 {
                        self.alert = (true, "Errore", "Errore interno al server. Se l'errore persiste contatta il supporto tecnico.")
                    }
                }
            }
    }
    
    func logout() {
        DispatchQueue.main.async {
            self.user = nil
        }
    }
    
    func register(name: String, surname: String, email: String, password: String, birthDate: Date) {
        
        // Generate the password MD5 hash
        let hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!)
        
        // Transform birth date to string
        let stringDate = formatter.string(from: birthDate)
        
        // Form a dictionary for posting data
        let body = ["name": name, "surname": surname, "email": email, "password": hashedPassw.description, "birthDate": stringDate]
        
        // Send the registration request to the API
        AF.request(API.register.rawValue, method: .post, parameters: body)
            .response { response in
                
                if let _ = response.response?.statusCode {
                    
                }
                
            }
        
    }
    
}
