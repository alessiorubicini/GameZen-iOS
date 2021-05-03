// CatalogView.swift
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
import SwiftUIX

struct CatalogView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var catalog: CatalogManager
    @EnvironmentObject private var cart: CartManager

    // Search bar variables
    @State var isEditing: Bool = false
    @State var searchText: String = ""
    
    
    // MARK: - View body
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            VStack {
                
                // Product search bar
                SearchBar("Cerca prodotto", text: $searchText, isEditing: $isEditing)
                    .showsCancelButton(isEditing)
                    .padding(.horizontal, 5)
                
                // If the user is not searching, show the default catalog view
                if searchText == "" {
                    
                    // Complete catalog
                    HStack {
                        Text("Catalogo completo").font(.title3).foregroundColor(.darkBlue).fontWeight(.medium)
                        Spacer()
                        NavigationLink(destination: ProductsListView(addToCart: cart.addProduct, products: catalog.products).navigationTitle("Catalogo completo")) {
                            Text("Sfoglia").foregroundColor(.bluePrimary).fontWeight(.medium)
                        }
                    }.padding()
                    
                    // Horizontal list of available products
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(catalog.products.filter{$0.available == true}) { product in
                                NavigationLink(destination: ProductView(product: product, addToCart: cart.addProduct).navigationTitle(product.name).navigationBarTitleDisplayMode(.inline)) {
                                    ProductCard(product: product).frame(height: 200)
                                }
                            }
                        }
                    }
                    
                    // Catalog categories
                    HStack {
                        Text("Categorie").font(.title3).foregroundColor(.darkBlue).fontWeight(.medium)
                        Spacer()
                    }.padding()
                    
                    List {
                        ForEach(catalog.categories) { category in
                            NavigationLink(destination: ProductsListView(addToCart: cart.addProduct, products: catalog.products.filter{$0.category == category.name})
                                            .navigationTitle(category.name)) {
                                HStack {
                                    Text(category.name).foregroundColor(.bluePrimary).fontWeight(.medium)
                                    Spacer()
                                    Text("\(category.numberOfProducts)").foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                } else {
                    // If the user is searching products, show the result
                    
                    List {
                        // Filter product list for searched name
                        ForEach(catalog.products.filter{$0.name.contains(searchText)}) { product in
                            ProductCard(product: product)
                                .frame(height: 200)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                }
                
            }
            .navigationTitle("Catalogo")
        }
        
        
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
            .environmentObject(CatalogManager())
            .environmentObject(CartManager())
    }
}
