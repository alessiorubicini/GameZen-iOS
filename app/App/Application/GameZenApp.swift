// GameZenApp.swift
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

// This is the main entry point of the app

@main
struct GameZenApp: App {
    
    // AppState is declared as @StateObject
    // In this way, it's instantiated only once in the whole app life-cycle
    @StateObject private var state = AppState()
    
    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            
            // If the user is not logged show the authentication view
            if self.state.isLogged == false {
                
                LoginView().environmentObject(state)
                
            } else {
                
                // If the user is logged, show the default app tab view
                // By default the catalog view is displayed as first
                TabView {
                    
                    CatalogView()
                        .environmentObject(state.catalogManager)
                        .environmentObject(state.cartManager)
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Catalogo")
                        }
                    
                    CartView()
                        .environmentObject(state)
                        .environmentObject(state.cartManager)
                        .tabItem {
                            Image(systemName: "cart.fill")
                            Text("Carrello")
                        }
                    
                    ProfileView()
                        .environmentObject(state)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profilo")
                        }
                    
                    SettingsView()
                        .environmentObject(state)
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Impostazioni")
                        }
                }
                .accentColor(.bluePrimary)
                
            }
            
        }
    }
    
}
