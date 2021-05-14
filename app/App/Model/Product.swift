// Product.swift
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

// Identifies a single product in the catalog
struct Product: Identifiable {
    
    let id: Int
    let name: String
    let category: String
    let description: String
    let year: Int
    let language: String
    let price: Double
    let available: Bool
    let imageURL: String
    
    // Coding keys used to parse the API JSON to Swift struct
    enum CodingKeys: String, CodingKey {
        case id = "code"
        case name = "name"
        case category = "category"
        case description = "description"
        case year = "year"
        case language = "language"
        case price = "price"
        case available = "available"
        case imageURL = "image"
    }
    
}

// Making the Product struct conform to Decodable protocol
extension Product: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.description = try container.decode(String.self, forKey: .description)
        self.year = try container.decode(Int.self, forKey: .year)
        self.language = try container.decode(String.self, forKey: .language)
        self.price = try container.decode(Double.self, forKey: .price)
        self.available = try container.decode(Bool.self, forKey: .available)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}

// Mock objects for debugging purposes
extension Product {
        
    static let mocks = [
        Product(id: 1, name: "Monopoly", category: "Strategici", description: "Il gioco di contrattazione più famoso del mondo. Compra, vendi, sogna e programma la tua strada verso la ricchezza. I giocatori comprano, vendono e contrattano per vincere; compra e vendi proprietà.", year: 2014, language: "ITA", price: 19.99, available: true, imageURL: "monopoly.jpg"),
        Product(id: 2, name: "Risiko", category: "Wargames", description: "Gioco da tavolo a squadre", year: 2018, language: "ITA", price: 29.99, available: false, imageURL: "")
    ]
    
}
