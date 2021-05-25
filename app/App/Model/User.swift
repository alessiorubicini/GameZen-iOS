// User.swift
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

// Identifies the user's account data
struct User {
    
    var id: Int
    var name: String
    var surname: String
    var email: String
    var password: String
    var birthDate: String
    var addresses: [Address]
    var orders: [Order]
    
    // Coding keys used to parse the API JSON to Swift struct
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case surname = "surname"
        case email = "email"
        case password = "password"
        case birthDate = "birth"
        case addresses = "addresses"
        case orders = "orders"
    }
    
}

// Making the User struct conform to Decodable protocol
extension User: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.birthDate = try container.decode(String.self, forKey: .birthDate)
        self.addresses = try container.decode([Address].self, forKey: .addresses)
        self.orders = try container.decode([Order].self, forKey: .orders)
    }
}

// Mock object for debugging purposes
extension User {
    static let mock = User(id: 1, name: "Alessio", surname: "Rubicini", email: "alessiorubicini16@icloud.com", password: "test", birthDate: "2002-07-16", addresses: [], orders: [])
}

