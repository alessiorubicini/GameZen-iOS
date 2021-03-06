// Category.swift
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

// Identifies a product category
struct Category: Identifiable, Codable {
    
    let id: Int
    let name: String
    let numberOfProducts: Int
    
}

// Mock objects for debugging purposes
extension Category {
    
    static let mocks = [
        Category(id: 1, name: "Wargames", numberOfProducts: 3),
        Category(id: 2, name: "Carte collezionabili", numberOfProducts: 1),
        Category(id: 3, name: "Strategici", numberOfProducts: 1)
    ]
    
}
