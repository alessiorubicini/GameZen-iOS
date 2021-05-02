// ProductView.swift
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
import SwiftUIComponents

struct ProductView: View {
    
    // MARK: - View properties
    
    let product: Product
    let addToCart: (Product) -> Bool
    
    // This flag displays an alert when the user try to add a product which is already added
    @State private var productAlreadyAdded = false
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            
            ScrollView {
                
                // Product image
                #if DEBUG
                Image(product.name).resizable().aspectRatio(contentMode: .fit).frame(height: 250).padding()
                #else
                RemoteImage(url: product.imageURL).padding()
                #endif
                
                // Product info
                Group {
                    Divider()
                    
                    Text(product.available ? "Disponibile" : "Esaurito").foregroundColor(product.available ? .green : .red)
                    
                    Divider()
                    
                    Text(product.description).padding()
                    
                    Divider()
                    
                    Text("Categoria: \(product.category)")
                    
                    Divider()
                    
                    Text("Lingua: \(product.language)")
                    
                    Divider()
                    
                    Text("\(product.price, specifier: "%.2f") €").font(.title)
                }
                
                Button("Aggiungi al carrello") {
                    
                    if !self.addToCart(product) {
                        // The product was already added to the cart
                        // Display an error alert
                        self.productAlreadyAdded.toggle()
                    }
                    
                }.buttonStyle(BlueButton()).disabled(!product.available)
                .padding(.top, 20)
                
            }
            
        }
        .alert(isPresented: $productAlreadyAdded, content: {
            Alert(title: Text("Errore"), message: Text("Il prodotto è già presente nel carrello"), dismissButton: .default(Text("Chiudi")))
        })
        
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.mocks[1], addToCart: { _ in return false})
    }
}
