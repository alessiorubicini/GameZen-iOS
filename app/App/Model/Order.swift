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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

struct Order: Codable {
    
    let id: Int
    let date: String
    let delivery: String
    let address: String
    let state: String
    let total: Double
    
}

extension Order {
    
    static let mocks = [
        Order(id: 1, date: "2021-05-01", delivery: "2021-05-09", address: "Via Mauro Macchi 52 - Porto San Giorgio, 63822", state: "In elaborazione", total: 39.99),
        Order(id: 1, date: "2021-04-30", delivery: "2021-05-12", address: "Via Mauro Macchi 52 - Porto San Giorgio, 63822", state: "In attesa di pagamento", total: 19.99)
    ]
    
}
