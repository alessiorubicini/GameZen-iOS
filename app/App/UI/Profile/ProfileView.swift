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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import SwiftUI

struct ProfileView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var userManager: UserManager
    
    @State private var editProfile = false
    @State private var data = User.Data()
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(header: Text("Informazioni")) {
                    InfoRow(key: "Nome", value: userManager.user!.name)
                    InfoRow(key: "Cognome", value: userManager.user!.surname)
                    InfoRow(key: "Email", value: userManager.user!.email)
                    InfoRow(key: "Data di nascita", value: userManager.user!.birthDate)
                }
                
                Section(header: Text("Azioni")) {
                    Button(action: {
                        self.editProfile.toggle()
                    }, label: {
                        Text("Modifica profilo").foregroundColor(.white)
                    }).listRowBackground(Color.bluePrimary)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Elimina profilo").foregroundColor(.white)
                    }).listRowBackground(Color.lightRed)
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Il tuo profilo")
            
            .sheet(isPresented: $editProfile, content: {
                NavigationView {
                    EditProfileView(data: $data)
                        .navigationTitle("Modifica profilo")
                        .navigationBarItems(leading: HStack {
                            
                            Button(action: {
                                self.editProfile.toggle()
                            }, label: {
                                Text("Annulla").foregroundColor(.lightRed)
                            })
                            
                        }, trailing: HStack {
                            
                            Button(action: {
                                self.userManager.updateProfile(data: self.data)
                            }, label: {
                                Text("Conferma").foregroundColor(.bluePrimary)
                            })
                            
                        })
                }
            })
            
        }
    }
}

struct InfoRow: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value).foregroundColor(.bluePrimary)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(UserManager())
    }
}