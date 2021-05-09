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

struct LoginView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject var state: AppState
    
    @State private var showRegistrationView = false
    
    @AppStorage("email") private var email = ""
    @AppStorage("password") private var password = ""
    @AppStorage("keepConnected") private var keepConnected = false
    
    // MARK: - View body
    
    @ViewBuilder
    var body: some View {
        
        if keepConnected {
            
            ProgressView()
            
            Text("Login automatico in corso...")
            
            Button(action: {
                self.keepConnected = false
            }, label: {
                Text("Interrompi login automatico")
            }).buttonStyle(RedButton())
            .padding(.top, 30)
            
        } else {
            
            VStack {
                
                // App logo
                Image(systemName: "cart.fill").resizable().aspectRatio(contentMode: .fit).frame(height: 150).padding(.vertical, 50)
                    .foregroundColor(.white)
                    .shadow(color: .darkBlue, radius: 20)
                
                Spacer()
                
                // Login form
                VStack {
                    
                    Text("Accedi a GameZen").font(.largeTitle).foregroundColor(.darkBlue)
                        .padding(.vertical)
                    
                    TextField("Email", text: $email).autocapitalization(.none).disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    
                    SecureField("Password", text: $password).autocapitalization(.none).disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        self.showRegistrationView.toggle()
                    }, label: {
                        Text("Non hai un profilo? Registrati!")
                    }).padding(.vertical)
                    
                    Button("Accedi") {
                        self.state.login(email: email, password: password)
                    }.buttonStyle(BlueButton()).padding()
                    
                }
                .background(Rectangle().fill(Color.white).cornerRadius(30.0)
                                .frame(height: 550))
                
            }
            .alert(isPresented: self.$state.alert.0, content: {
                Alert(title: Text(state.alert.1), message: Text(state.alert.2), dismissButton: .default(Text("Chiudi")))
            })
            
            .sheet(isPresented: $showRegistrationView, content: {
                NavigationView {
                    RegistrationView()
                        .navigationTitle("Registrati")
                        
                        .navigationBarItems(leading: HStack {
                            Button(action: {
                                self.showRegistrationView.toggle()
                            }, label: {
                                Text("Annulla").foregroundColor(.red)
                            })
                        })
                        
                        .environmentObject(self.state)
                }
            })

            .background(Color.bluePrimary.edgesIgnoringSafeArea(.all))
            
        }
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppState())
    }
}
