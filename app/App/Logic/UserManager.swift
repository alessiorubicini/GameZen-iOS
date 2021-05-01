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
import Alamofire
import CryptoKit

class UserManager: ObservableObject {

    var user: User? = nil
    
    func login(username: String, password: String) throws {

        // Generate the password MD5 hash
        let hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!)
        
        // Send the login request to the API
        AF.request(API.login.rawValue, method: .post, parameters: ["username": username, "password": hashedPassw])
            .response { response in
                
                
            }
        
    }
    
    func register() throws {
        
    }
    
}

