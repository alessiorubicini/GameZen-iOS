// UserManager.swift
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
import CryptoKit

class UserManager: ObservableObject {

    // MARK: - Properties
    
    var user: User?
    @Published var authenticationError = (false, "", "")
    
    init() {
        #if DEBUG
        // Assigning a mock object for debugging purposes
        self.user = User(id: 87, name: "Alessio", surname: "Rubicini", email: "alessiorubicini16@icloud.com", password: "test", birthDate: "16/07/2002", addresses: Address.mocks, orders: Order.mocks)
        #else
        // User object is nil by default
        self.user = nil
        #endif
    }
    
    // MARK: - Methods
    
    func login(email: String, password: String) {
        
        // Generate the password MD5 hash
        let hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!)
        
        // Send the login request to the API
        AF.request(API.login.rawValue, method: .post, parameters: ["email": email, "password": hashedPassw])
            .response { response in
                
                if let statusCode = response.response?.statusCode {
                    if statusCode == 403 {
                        self.authenticationError = (true, "Credenziali non corrette", "Controlla le credenziali inserite")
                    } else if statusCode == 404 {
                        self.authenticationError = (true, "Utente non trovato", "Controlla le credenziali inserite o registrati al negozio")
                    } else if statusCode == 500 {
                        self.authenticationError = (true, "Errore", "Errore interno al server. Se l'errore persiste contatta il supporto tecnico.")
                    }
                }
                
                do {
                    // Parse user info as JSON to Swift struct
                    let user = try JSONDecoder().decode(User.self, from: response.data!)
                    
                    self.user = user
                    
                } catch {
                    
                    
                    
                }
                
            }
        
    }
    
    func logout() {
        self.user = nil
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
                
                if let statusCode = response.response?.statusCode {
                    
                }
                
            }
        
    }
    
    func updateProfile(data: User.Data) {
        
    }
    
}

