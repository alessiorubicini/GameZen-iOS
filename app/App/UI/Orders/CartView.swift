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
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import SwiftUI

struct CartView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    @EnvironmentObject private var cart: CartManager
    
    @State private var deliveryAddress = 0
    
    // MARK: - View body
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            VStack {
                
                if cart.products.count == 0 {
                    
                    Group {
                        Image("EmptyCart").resizable().aspectRatio(contentMode: .fit).frame(width: 230)
                        Text("Il tuo carrello è vuoto").font(.title2).foregroundColor(.darkBlue).fontWeight(.medium)
                    }.padding(.vertical)
                    
                } else {
                    
                    Text("Totale: \(cart.totalPrice, specifier: "%.2f") €").font(.title).padding(.top)
                    
                    if self.state.user!.addresses.count == 0 {
                        Text("Per effettuare un ordine è necessario aggiungere un indirizzo di consegna").multilineTextAlignment(.center).padding()
                    } else {
                        Picker(deliveryAddress == 0 ? "Seleziona indirizzo di consegna" : "Cambia indirizzo di consegna", selection: $deliveryAddress) {
                            ForEach(state.user!.addresses) { address in
                                Text("\(address.address) \(address.civic) - \(address.city)").font(.body)
                            }
                        }.pickerStyle(MenuPickerStyle())
                    }
                    
                    Button("Invia ordine") {
                        
                        self.state.makeOrder(addressID: self.deliveryAddress, total: self.cart.totalPrice, products: self.cart.products)
                        
                    }.buttonStyle(BlueButton()).disabled(cart.products.count == 0 || self.deliveryAddress == 0)
                    .padding(.top, 30)
                    
                    List {
                        
                        ForEach(cart.products) { product in
                            NavigationLink(destination: ProductView(product: product, addToCart: cart.addProduct).navigationTitle(product.name).navigationBarTitleDisplayMode(.inline)) {
                                ProductCard(product: product).frame(height: 150)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            withAnimation {
                                self.cart.removeProduct(at: indexSet)
                            }
                        })

                    }
                    .listStyle(PlainListStyle())
                    .padding(.top, 15)

                }
                
                
            }
            .navigationTitle("Il tuo carrello")
            
            .alert(isPresented: self.$state.alert.0, content: {
                Alert(title: Text(state.alert.1), message: Text(state.alert.2), dismissButton: .default(Text("Chiudi")))
            })

        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(AppState())
            .environmentObject(CartManager())
    }
}
