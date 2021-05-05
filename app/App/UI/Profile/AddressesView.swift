// AddressesView.swift
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

struct AddressesView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    
    @State private var addNewAddress = false
    @State private var data = Address.Data()
    
    // MARK: - View body
    
    var body: some View {
        List {
            Section {
                Button(action: {
                    self.addNewAddress.toggle()
                }, label: {
                    Text("Aggiungi indirizzo")
                })
            }
            .sheet(isPresented: $addNewAddress, content: {
                NavigationView {
                    AddAddressView(data: $data)
                        .navigationTitle("Nuovo indirizzo")
                        .navigationBarItems(leading: HStack {
                            
                            Button(action: {
                                self.addNewAddress.toggle()
                            }, label: {
                                Text("Annulla").foregroundColor(.lightRed)
                            })
                            
                        }, trailing: HStack {
                            
                            Button(action: {
                                
                                // Close sheet view
                                self.addNewAddress.toggle()
                                
                                self.state.addAddress(data: self.data)
                                
                            }, label: {
                                Text("Conferma").foregroundColor(.bluePrimary)
                            })
                            
                        })
                        .alert(isPresented: self.$state.alert.0, content: {
                            Alert(title: Text(state.alert.1), message: Text(state.alert.2), dismissButton: .default(Text("Chiudi")))
                        })
                }
            })
            
            ForEach(state.user!.addresses) { address in
                Section(header: Text(address.address)) {
                    InfoRow(key: "Indirizzo", value: address.address)
                    InfoRow(key: "Civico", value: "\(address.civic)")
                    InfoRow(key: "Città", value: address.city)
                    InfoRow(key: "CAP", value: "\(address.CAP)")
                    InfoRow(key: "Provincia", value: address.province)
                    InfoRow(key: "Telefono", value: "\(address.phone)")
                    
                    Button(action: {
                        self.state.removeAddress(of: address.id)
                    }, label: {
                        Text("Elimina indirizzo").foregroundColor(.lightRed)
                    })
                    
                }
            }
            
        }.listStyle(InsetGroupedListStyle())
    }
    
}

struct AddressesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressesView().environmentObject(AppState())
                .navigationTitle("Indirizzi")
        }
    }
}
