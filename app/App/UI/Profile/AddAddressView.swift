// AddAddressView.swift
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

import SwiftUI

// This view displays a form to add a new delivery address
// It's displayed as a sheet when the user want to add a new address
struct AddAddressView: View {
    
    // MARK: - View properties
    @Binding var data: Address.Data
    
    // MARK: - View body
    
    var body: some View {
        Form {
            TextField("Via", text: $data.address)
            TextField("Numero civico", text: $data.civic).keyboardType(.numberPad)
            TextField("Città", text: $data.city)
            TextField("CAP", text: $data.CAP).keyboardType(.numberPad)
            TextField("Provincia", text: $data.province)
            TextField("Telefono", text: $data.phone).keyboardType(.numberPad)
        }
    }
}

struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView(data: .constant(Address.Data()))
    }
}
