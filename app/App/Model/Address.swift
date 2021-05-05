// Address.swift
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

struct Address: Codable, Identifiable {
    
    let id: Int
    let address: String
    let civic: Int
    let city: String
    let CAP: Int
    let province: String
    let phone: Int
    
}

extension Address {
    
    struct Data {
        var address: String = ""
        var civic: String = ""
        var city: String = ""
        var CAP: String = ""
        var province: String = ""
        var phone: String = ""
    }
    

}

// Mock objects for debugging purposes
extension Address {
    
    static let mocks = [
        Address(id: 1, address: "Via Mauro Macchi", civic: 52, city: "Porto San Giorgio", CAP: 63822, province: "FM", phone: 3896970199),
        Address(id: 2, address: "Viale Trento", civic: 23, city: "Fermo", CAP: 63900, province: "FM", phone: 3896970199)
    ]
    
}
