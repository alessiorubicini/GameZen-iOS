// EditProfileView.swift
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

import SwiftUI

struct EditProfileView: View {
    
    // MARK: - View properties
    @Binding var data: User.Data
    
    // MARK: - View body
    
    var body: some View {
        Form {
            TextField("Nome", text: $data.name)
            TextField("Cognome", text: $data.surname)
            TextField("Email", text: $data.email)
            DatePicker(selection: $data.birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Data di nascita")
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(data: .constant(User.Data()))
    }
}
