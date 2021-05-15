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
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import Foundation
import SwiftUI
import Alamofire
import CryptoKit

// Extends the AppState object for authentication logic
extension AppState {
    
    /// Login into an existing account
    func login(email: String, password: String) {
        
        // Generate the password MD5 hash
        var hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!).description.split(separator: ":")[1]
        hashedPassw.remove(at: hashedPassw.startIndex)
        
        // Send the login request to the API
        AF.request(API.login.rawValue, method: .post, parameters: ["email": email, "password": hashedPassw])
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the request has been completed successfully
                    if statusCode == 200 {
                      
                        // Try to save user information
                        do {
                            // Parse user info as JSON to Swift struct
                            let user = try JSONDecoder().decode(User.self, from: response.data!)
                            
                            // Set the user struct
                            DispatchQueue.main.async {
                                self.isLogged = true
                                self.user = user
                            }
                            
                            // Save user ID to the app local storage
                            UserDefaults.standard.setValue(user.id, forKey: "userID")
                            
                            // Fetch all the data from APIs
                            self.catalogManager.loadAllProducts()
                            self.catalogManager.loadCategories()
                            self.cartManager.getUserCart()
                            
                        } catch {
                            
                            print(error)
                            self.alert = (true, "Errore sconosciuto nell'autenticazione", error.localizedDescription)
                            
                        }
                        
                    } else if statusCode == 403 {
                        
                        // HTTP status code 403: forbidden access
                        self.alert = (true, "Credenziali non corrette", "Controlla le credenziali inserite")
                        
                    } else if statusCode == 404 {
                        
                        // HTTP Status code 404: user not found
                        self.alert = (true, "Utente non trovato", "Controlla le credenziali inserite o registrati al negozio se non possiedi un account")
                        
                    } else if statusCode == 500 {
                        
                        // HTTP Status code 500: internal server error
                        self.alert = (true, "Errore interno al server", "Se l'errore persiste contatta il supporto tecnico.")
                        
                    }
                }
            }
    }
    
    
    /// Register a new user
    func register(name: String, surname: String, email: String, password: String, birthDate: Date) {
        
        // Generate the password MD5 hash
        var hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!).description.split(separator: ":")[1]
        hashedPassw.remove(at: hashedPassw.startIndex)
        
        // Transform birth date to string
        let stringDate = formatter.string(from: birthDate)
        
        // Form a dictionary for posting data
        let body = ["name": name, "surname": surname, "email": email, "password": hashedPassw.description, "birthDate": stringDate]
        
        // Send the registration request to the API
        AF.request(API.register.rawValue, method: .post, parameters: body)
            .response { response in
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the request has been completed successfully
                    if statusCode == 200 {
                        
                        // Close the registration sheet view
                        self.showRegistrationSheet = false
                        
                        // Display an alert
                        showStatusAlert(icon: "person.crop.circle.fill.badge.checkmark", title: "Registrato con successo", message: "Inserisci le credenziali per effettuare l'accesso")
                        
                    } else {
                        
                        // Display an alert
                        self.alert = (true, "Errore nella registrazione", String(data: response.data!, encoding: .utf8)!)
                        
                    }
                    
                }
                
            }
        
    }
    
    /// Logout from user account
    func logout() {
        
        // Reset user preferences and information
        UserDefaults.standard.setValue(false, forKey: "keepConnected")
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "password")
        
        // Log out from account
        DispatchQueue.main.async {
            self.isLogged = false
            //self.user = nil
            
        }
    }
    
    /// Delete the user account
    func deleteAccount() {
        
        // Delete account from database through APIs
        AF.request(API.deleteAccount.rawValue + "?userID=\(UserDefaults.standard.integer(forKey: "userID"))", method: .get)
            .response { response in
                
                debugPrint(response)
                
                // Check and convert status code to non-optional value
                if let statusCode = response.response?.statusCode {
                    
                    // Check if the request has been completed successfully
                    if statusCode == 200 {
                        
                        // Logout
                        self.logout()
                        
                        // Display an alert
                        showStatusAlert(icon: "xmark.square.fill", title: "Eliminato", message: "Account eliminato con successo")
                        
                    } else {
                        
                        // Display an alert
                        self.alert = (true, "Errore nella cancellazione dell'account", String(data: response.data!, encoding: .utf8)!)
                        
                    }
                    
                }
                
            }

        
    }
}
