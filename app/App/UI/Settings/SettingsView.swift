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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import SwiftUI

struct SettingsView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    
    @AppStorage("rememberAccount") private var rememberAccount = false
    
    @State private var showFAQ = false
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(header: Text("Preferenze")) {
                    Toggle("Rimani collegato", isOn: $rememberAccount)
                }
                
                Section(header: Text("Informazioni")) {
                    HStack {
                        Text("Versione app")
                        Spacer()
                        Text("1.0.0")
                    }
                    
                    Button(action: {
                        self.showFAQ.toggle()
                    }, label: {
                        Text("F.A.Q.")
                    })
                    .sheet(isPresented: $showFAQ, content: {
                        NavigationView {
                            FAQView()
                                .navigationTitle("F.A.Q.")
                                .navigationBarItems(trailing: HStack {
                                    Button(action: {
                                        self.showFAQ.toggle()
                                    }, label: {
                                        Text("Chiudi")
                                    })
                                })
                        }
                    })
                    
                    Text("Area legale")
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Impostazioni")
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AppState())
    }
}
