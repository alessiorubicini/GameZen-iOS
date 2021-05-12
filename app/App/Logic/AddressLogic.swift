// AddressLogic.swift
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

extension AppState {
    
    /// Load user's addresses from database through APIs
    func loadAddresses() {
        
        // Send a GET request
        AF.request(API.getAddresses.rawValue + "?userID=\(UserDefaults.standard.integer(forKey: "userID"))", method: .get)
            .response { response in
                do {
                    // Parse user info as JSON to Swift struct
                    let addresses = try JSONDecoder().decode([Address].self, from: response.data!)
                    
                    // Replace user addresses
                    self.user!.addresses = []
                    self.user!.addresses = addresses
                    
                } catch {
                    
                    print("ERROR while fetching addresses from catalog")
                    fatalError(error.localizedDescription)
                    
                }
            }
        
    }
    
    
    
    /// Add a new address to the user's delivery addresses
    /// - Parameter data: struct containing Address' data
    func addAddress(data: Address.Data) {
        
        // Form a dictionary for posting data
        let body: [String:Any] = ["userID": UserDefaults.standard.integer(forKey: "userID"), "address": data.address, "civic": Int(data.civic) ?? 0, "city": data.city, "CAP": Int(data.CAP) ?? 0, "province": data.province, "phone": Int(data.phone) ?? 0]
        
        // Add address to database through API
        AF.request(API.postAddress.rawValue, method: .post, parameters: body)
            .response { response in
                
                if let statusCode = response.response?.statusCode {
                    
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                        showStatusAlert(icon: "mappin.and.ellipse", title: "Aggiunto", message: "Indirizzo di consegna aggiunto con successo")
                        
                        // Reload addresses
                        self.loadAddresses()
                        
                    } else {
                        
                        // Generate error haptic feedback
                        HapticGenerator().notificationFeedback(type: .error)
                        
                        // Display an alert
                        self.alert = (true, "Errore nell'aggiunta dell'indirizzo", String(data: response.data!, encoding: .utf8)!)
                        
                    }
                    
                }
                
            }
        
    }
    
    
    /// Remove the address with the given id
    /// - Parameter id: address' id
    func removeAddress(of id: Int) {
        
        // Remove address from database through API
        AF.request(API.deleteAddress.rawValue, method: .post, parameters: ["addressID": id])
            .response { response in
                
                if let statusCode = response.response?.statusCode {
                    
                    if statusCode == 200 {
                        
                        // Generate success haptic feedback
                        HapticGenerator().notificationFeedback(type: .success)
                        
                        showStatusAlert(icon: "mappin.slash", title: "Rimosso", message: "Indirizzo di consegna rimosso")
                        
                        // Reload addresses
                        self.loadAddresses()
                        
                    } else {
                        
                        // Generate error haptic feedback
                        HapticGenerator().notificationFeedback(type: .error)
                        
                        // Display an alert
                        self.alert = (true, "Errore nell'eliminazione dell'indirizzo", response.description)
                        
                    }
                    
                }
                
            }
        
        // Reload addresses
        self.loadAddresses()
        
    }
    
}
