// SettingsView.swift
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

struct SettingsView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    
    @AppStorage("keepConnected") private var keepConnected = false
    
    @State private var showFAQ = false
    @State private var showCredits = false
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            
            List {
                
                // General settings
                Section(header: Text("Generale")) {
                    Toggle("Rimani collegato", isOn: $keepConnected).foregroundColor(.darkBlue)
                    
                    Button(action: {
                        shareApp()
                    }, label: {
                        Label("Condividi l'app", systemImage: "square.and.arrow.up")
                    })
                    
                    Link(destination: URL(string: "http://alessiorubicini.altervista.org")!) {
                        Label("Contatta il supporto", systemImage: "envelope.fill")
                    }
                }
                
                // Information about the app
                Section(header: Text("Informazioni")) {
                    
                    Button("Domande frequenti", action: {
                        self.showFAQ.toggle()
                    })
                    
                    // F.A.Q. modal view
                    .sheet(isPresented: $showFAQ, content: {
                        NavigationView {
                            FAQView()
                                .navigationTitle("F.A.Q.")
                                .navigationBarItems(trailing: HStack {
                                    Button(action: {
                                        self.showFAQ.toggle()
                                    }, label: {
                                        Image(systemName: "xmark").foregroundColor(.darkBlue)
                                            .font(Font.title2.weight(.bold)).padding(5)
                                    })
                                })
                        }
                    })
                    
                    NavigationLink(destination: EmptyView()) {
                        Text("Privacy policy").foregroundColor(.darkBlue)
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Termini di utilizzo").foregroundColor(.darkBlue)
                    }
                    
                }
                
                // Other information about the app
                Section {
                    
                    // App version number
                    HStack {
                        Text("Versione app")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)
                    }.foregroundColor(.darkBlue)
                    
                    // Link to the developer website
                    Link("Sviluppatore", destination: URL(string: "http://alessiorubicini.altervista.org")!)
                    
                    // Credits
                    Button("Crediti") {
                        self.showCredits.toggle()
                    }
                    .sheet(isPresented: $showCredits, content: {
                        NavigationView {
                            CreditsView()
                                .navigationTitle("Crediti e ringraziamenti")
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarItems(trailing: HStack {
                                    Button(action: {
                                        self.showCredits.toggle()
                                    }, label: {
                                        Image(systemName: "xmark").foregroundColor(.darkBlue)
                                            .font(Font.title2.weight(.bold)).padding(5)
                                    })
                                })
                        }
                    })
                }

                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Impostazioni")
            
        }
    }
}

// SwiftUI debugging preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AppState())
    }
}
