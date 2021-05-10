// ProductsListView.swift
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

struct ProductsListView: View {
    
    // MARK: - View properties
    
    let addToCart: (Product) -> Bool
    let products: [Product]
    
    // Search bar variables
    @State var isEditing: Bool = false
    @State var searchText: String = ""

    
    // MARK: - View body
    
    var body: some View {
        
        VStack {
            // Product search bar
            SearchBar("Cerca prodotto", text: $searchText, isEditing: $isEditing)
                .showsCancelButton(isEditing)
                .padding(5)
            
            List {

                ForEach(searchText.isEmpty ? products : products.filter({$0.name.contains(searchText)})) { product in
                    NavigationLink(destination: ProductView(product: product, addToCart: addToCart).navigationTitle(product.name)) {
                        ProductCard(product: product).frame(height: 200)
                    }
                }
                
            }
        }
        
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(addToCart: { _ in return false }, products: Product.mocks)
    }
}
