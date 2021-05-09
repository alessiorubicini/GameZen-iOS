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
                RemoteImage(type: .view, url: API.images.rawValue + product.imageURL).padding()
                //.resizable().aspectRatio(contentMode: .fit).frame(height: 230).padding()
                
                // Product info
                VStack(alignment: .leading) {
                    Text(product.name).font(.title).fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.bottom, 1)
                    
                    HStack {
                        Text("\(product.price, specifier: "%.2f") €")
                        Text(product.available ? "Disponibile" : "Esaurito")
                            .foregroundColor(product.available ? .green : .red)
                    }.font(.title3).padding(.horizontal)
                    
                    VStack {
                        Divider()
                        HStack {
                            VStack(alignment: .leading) {
                                Text("CATEGORIA")
                                Text(product.category)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("LINGUA")
                                Text(product.language)
                            }
                        }
                        Divider()
                    }.padding(.horizontal).padding(.vertical, 5)

                    Text(product.description).lineLimit(10).minimumScaleFactor(0.5).padding()
                    
                    
                }.foregroundColor(.darkBlue)
                
                
                
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
        
        .navigationBarItems(trailing: HStack {
            Button(action: {
                shareProduct(product: self.product)
            }, label: {
                Image(systemName: "square.and.arrow.up").font(.title2).foregroundColor(.bluePrimary)
            })
    })
        
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductView(product: Product.mocks[0], addToCart: { _ in return false})
                .navigationTitle(Product.mocks[1].name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
