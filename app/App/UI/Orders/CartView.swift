// CartView.swift
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

// This view displays the current user's cart
// It's displayed as one of the views in the bottom tab bar
struct CartView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    @EnvironmentObject private var cart: CartManager
    
    @State private var deliveryAddress = 0
    @State private var selectAddress = false
    
    // MARK: - View body
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            VStack {
                
                // Empty cart
                if cart.products.count == 0 {
                    
                    Group {
                        Image("EmptyCart").resizable().aspectRatio(contentMode: .fit).frame(width: 230)
                        Text("Il tuo carrello è vuoto").font(.title2).foregroundColor(.darkBlue).fontWeight(.medium)
                    }.padding(.vertical)
                    
                } else {
                    // Non-empty cart
                    
                    // Total price of the cart
                    Text("Totale: \(cart.totalPrice, specifier: "%.2f") €").foregroundColor(.darkBlue).font(.title).padding(.top)
                    
                    // Check if user has delivery addresses
                    if self.state.user!.addresses.count == 0 {
                        Text("Per effettuare un ordine è necessario aggiungere un indirizzo di consegna").multilineTextAlignment(.center).padding()
                    } else {
                        Button(deliveryAddress == 0 ? "Seleziona un indirizzo di consegna" : "Cambia indirizzo di consegna") {
                            self.selectAddress.toggle()
                        }.padding(.top)
                    }
                    
                    Button("Invia ordine") {
                        
                        self.state.makeOrder(addressID: self.deliveryAddress, total: self.cart.totalPrice, products: self.cart.products)
                        
                    }.buttonStyle(BlueButton()).disabled(cart.products.count == 0 || self.deliveryAddress == 0)
                    .padding(.top, 30)
                    
                    List {
                        
                        // List of all products inside the cart
                        ForEach(cart.products) { product in
                            NavigationLink(destination: ProductView(product: product, addToCart: cart.addProduct).navigationTitle(product.name).navigationBarTitleDisplayMode(.inline)) {
                                ProductCard(product: product).frame(height: 150)
                            }
                        }
                        
                        // Delete an item from the cart on swipe
                        .onDelete(perform: { indexSet in
                            withAnimation {
                                self.cart.removeProduct(at: indexSet)
                            }
                        })

                    }
                    .listStyle(PlainListStyle())
                    .padding(.top, 15)
                    
                    .actionSheet(isPresented: $selectAddress) {
                        let buttons = self.state.user!.addresses.enumerated().map { i, address in
                            Alert.Button.default(self.deliveryAddress == 0 ? Text("\(address.address) \(address.civic) - \(address.city)") : Text("✅ \(address.address) \(address.civic) - \(address.city)"),
                                                 action: { self.deliveryAddress = address.id} )
                        }
                        return ActionSheet(title: Text("Indirizzo di consegna"), message: Text("Indica l'indirizzo a cui consegnare l'ordine"), buttons: buttons + [Alert.Button.cancel()])
                    }

                }
                
                
            }
            .navigationTitle("Il tuo carrello")
            
            .alert(isPresented: self.$state.alert.0, content: {
                Alert(title: Text(state.alert.1), message: Text(state.alert.2), dismissButton: .default(Text("Chiudi")))
            })

        }
    }
}

// SwiftUI debugging preview
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(AppState())
            .environmentObject(CartManager())
    }
}
