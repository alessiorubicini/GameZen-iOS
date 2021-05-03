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
    
    @EnvironmentObject private var cart: CartManager
    
    @State private var proceedToOrder = false
    
    // MARK: - View body
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            VStack {
                
                if cart.products.count == 0 {
                    
                    Group {
                        Image(systemName: "cart").foregroundColor(.bluePrimary).font(.system(size: 150))
                        Text("Il tuo carrello è vuoto").font(.title2).foregroundColor(.bluePrimary)
                    }.padding(.vertical)
                    
                } else {
                    
                    Text("Totale: \(cart.totalPrice, specifier: "%.2f") €").font(.title).padding(.top)
                    
                    Button("Procedi all'ordine") {
                        self.proceedToOrder.toggle()
                    }.buttonStyle(BlueButton()).disabled(cart.products.count == 0)
                    .padding(.top, 30)
                    
                    List {
                        
                        ForEach(cart.products) { product in
                            NavigationLink(destination: ProductView(product: product, addToCart: cart.addProduct).navigationTitle(product.name).navigationBarTitleDisplayMode(.inline)) {
                                ProductCard(product: product).frame(height: 150)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            cart.products.remove(atOffsets: indexSet)
                        })

                    }
                    .listStyle(PlainListStyle())
                    
                    .sheet(isPresented: $proceedToOrder, content: {
                        NavigationView {
                            ProceedToOrderView(products: cart.products)
                                .navigationTitle("Riepilogo ordine")
                        }
                    })
                }
                
                
            }
            .navigationTitle("Il tuo carrello")
            
            .sheet(isPresented: $proceedToOrder, content: {
                Text("Ordine")
            })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
