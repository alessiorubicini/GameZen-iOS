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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

struct Product: Identifiable, Codable {
    
    let id: Int
    let name: String
    let category: String
    let description: String
    let year: String
    let language: String
    let price: Double
    let available: Bool
    let imageURL: String
    
}

extension Product {
    
    static let mocks = [
        Product(id: 1, name: "YuGiOh", category: "Carte collezionabili", description: "Mazzo da carte", year: "2020", language: "ITA", price: 39.99, available: true, imageURL: ""),
        Product(id: 2, name: "Monopoly", category: "Strategici", description: "Gioco da tavolo a squadre", year: "2014", language: "ITA", price: 19.99, available: true, imageURL: ""),
        Product(id: 3, name: "Risiko", category: "Wargames", description: "Gioco da tavolo a squadre", year: "2018", language: "ITA", price: 29.99, available: false, imageURL: "")
    ]
    
}
