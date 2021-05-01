// AuthenticationView.swift
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

struct AuthenticationView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var userManager: UserManager
    @State private var auth: AuthView = .login
    
    // Login fields
    @State private var email = ""
    @State private var password = ""
    
    // Registration fields
    @State private var newName = ""
    @State private var newSurname = ""
    @State private var newEmail = ""
    @State private var newPassword = ""
    @State private var birthDate = Date()
    
    // MARK: - View body
    
    @ViewBuilder
    var body: some View {
        
        VStack {

            
            // Authentication menu
            Picker(selection: $auth, label: Text("Auth"), content: {
                Text("Accedi").tag(AuthView.login)
                Text("Registrati").tag(AuthView.register)
            }).pickerStyle(SegmentedPickerStyle())
            .padding()
            
            //Spacer()
            
            Image("Monopoly").resizable().aspectRatio(contentMode: .fit).frame(height: 200).padding()
            
            
            if auth == .login {
                
                Text("Accedi a GameZen").font(.largeTitle)
                
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
                TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                
                Button("Accedi") {
                    
                }.buttonStyle(BlueButton()).padding()
                
            } else {
                
                Text("Registrati a GameZen").font(.largeTitle)
                
                TextField("Nome", text: $newName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(10)
                
                TextField("Cognome", text: $newSurname).textFieldStyle(RoundedBorderTextFieldStyle()).padding(10)
                
                TextField("Email", text: $newEmail).textFieldStyle(RoundedBorderTextFieldStyle()).padding(10)
                
                TextField("Password", text: $newPassword).textFieldStyle(RoundedBorderTextFieldStyle()).padding(10)
                
                DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                    Text("Data di nascita")
                }.padding(10)
                
                Button("Registrati") {
                    
                }.buttonStyle(BlueButton()).padding()
            }
            
            Spacer()
            
        }
        
    }
    
    private enum AuthView {
        case login
        case register
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView().environmentObject(UserManager())
    }
}
