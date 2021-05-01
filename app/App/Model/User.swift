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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

struct User {
    
    let id: Int
    let name: String
    let surname: String
    let email: String
    let password: String
    let birthDate: String
    
}

extension User {
    struct Data {
        var name = ""
        var surname = ""
        var email = ""
        var birthDate = Date()
    }
    
    var data: Data {
        return Data(name: name, surname: surname, email: email, birthDate: formatter.date(from: birthDate)!)
    }

}

var formatter: DateFormatter {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
    
}
