// ProfileView.swift
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
import LocalAuthentication

// This view displays the user info after the login
// It's displayed as one of the views in the bottom tab bar
struct ProfileView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    @State private var showDeleteAccountView = false
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            
            List {
                
                // User general information
                Section(header: Text("Informazioni")) {
                    InfoRow(key: "Nome", value: state.user!.name)
                    InfoRow(key: "Cognome", value: state.user!.surname)
                    InfoRow(key: "Email", value: state.user!.email)
                    InfoRow(key: "Data di nascita", value: state.user!.birthDate)
                    
                    NavigationLink(destination: AddressesView().environmentObject(self.state).navigationTitle("Indirizzi")) {
                        Text("Indirizzi di consegna")
                    }
                    
                    NavigationLink(destination: OrdersListView(orders: state.user!.orders).navigationTitle("Ordini")) {
                        Text("Ordini effettuati")
                    }
                }
                
                // Actions that the user can execute
                Section(header: Text("Azioni")) {
                    
                    // Delete account
                    Button(action: {
                        
                        self.showDeleteAccountView.toggle()
                        
                    }, label: {
                        Text("Elimina profilo").foregroundColor(.red)
                    })
                    
                    .sheet(isPresented: $showDeleteAccountView, content: {
                        NavigationView {
                            DeleteAccountView().environmentObject(self.state)
                                .navigationTitle("Eliminazione account")
                                .navigationBarItems(leading: HStack {
                                    Button(action: {
                                        self.showDeleteAccountView.toggle()
                                    }, label: {
                                        Text("Annulla")
                                    })
                                })
                        }
                    })
                    
                    // Logout
                    Button(action: {
                        self.state.logout()
                    }, label: {
                        Text("Esci dall'account").foregroundColor(.red)
                    })
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Il tuo profilo")
            
        }
    }
}

// SwiftUI debugging preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AppState())
    }
}
