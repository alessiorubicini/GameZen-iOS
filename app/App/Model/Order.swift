// Order.swift
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

// Identifies a sent order
struct Order: Identifiable {
    
    let id: Int
    let date: String
    let delivery: String
    let address: String
    let state: String
    let total: Double
    let products: [Product]
    
    // Coding keys used to parse the API JSON to Swift struct
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case delivery = "delivery"
        case address = "address"
        case state = "state"
        case total = "total"
        case products = "products"
    }
    
    /// Get the order's progress based on string status
    /// - Returns: order's progress as float
    func getOrderProgress() -> Float {
        switch self.state {
        case "In attesa di pagamento": return 1.0
        case "Pagamento ricevuto": return 2.0
        case "In elaborazione": return 3.0
        case "Spedito": return 4.0
        case "In consegna": return 5.0
        case "Consegnato": return 6.0
        default: return 0.0
        }
    }
    
}

// Making the Order struct conform to Decodable protocol
extension Order: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decode(String.self, forKey: .date)
        self.delivery = try container.decode(String.self, forKey: .delivery)
        self.address = try container.decode(String.self, forKey: .address)
        self.state = try container.decode(String.self, forKey: .state)
        self.total = try container.decode(Double.self, forKey: .total)
        self.products = try container.decode([Product].self, forKey: .products)
    }
}




// Mock objects for debugging purposes
extension Order {
    
    static let mocks = [
        Order(id: 1, date: "2021-05-01", delivery: "2021-05-09", address: "Via Mauro Macchi 52 - Porto San Giorgio, 63822", state: "Spedito", total: 39.99, products: []),
        Order(id: 1, date: "2021-04-30", delivery: "2021-05-12", address: "Via Mauro Macchi 52 - Porto San Giorgio, 63822", state: "In attesa di pagamento", total: 19.99, products: [])
    ]
    
}
