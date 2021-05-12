// RegistrationView.swift
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

struct RegistrationView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    @Environment(\.presentationMode) var presentationMode
    
    // Registration fields
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var birthDate = Date()
    @State private var acceptPolicy = false
    
    // MARK: - View body
    
    var body: some View {
        Form {
            
            Section {
                TextField("Nome", text: $name)
                
                TextField("Cognome", text: $surname)
                
                TextField("Email", text: $email).autocapitalization(.none)
                
                SecureField("Password", text: $password).autocapitalization(.none)
                SecureField("Conferma password", text: $confirmPassword).autocapitalization(.none)
                
                DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                    Text("Data di nascita")
                }
                
                Toggle("Dichiaro di accettare le condizioni d'uso e la Privacy Policy", isOn: $acceptPolicy).font(.callout)
            }
            
            Section {
                Button(action: {
                    
                    // Check password
                    if password != confirmPassword {
                        self.state.alert = (true, "Errore", "Le password non corrispondono")
                        return
                    }
                    
                    // Check if user accepted conditions and policy
                    if acceptPolicy == false {
                        self.state.alert = (true, "Errore", "Per registrarsi è necessario accettare le condizioni e la privacy policy")
                        return
                    }
                    
                    // Register the new user
                    self.state.register(name: name, surname: surname, email: email, password: password, birthDate: birthDate)
                    
                }, label: {
                    Text("Conferma").fontWeight(.semibold)
                })
                
                Button(action: {
                    
                }, label: {
                    Text("Condizioni d'uso")
                })
                
                Button(action: {
                    
                }, label: {
                    Text("Privacy Policy")
                })
            }
            
        }
        .alert(isPresented: self.$state.alert.0, content: {
            Alert(title: Text(state.alert.1), message: Text(state.alert.2), dismissButton: .default(Text("Chiudi")))
        })
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrationView().environmentObject(AppState())
                .navigationTitle("Registrati")
        }
    }
}
