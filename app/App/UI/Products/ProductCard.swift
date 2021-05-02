// ProductCard.swift
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

struct ProductCard: View {
    
    // MARK: - View properties
    
    let product: Product
    
    // MARK: - View body
    
    var body: some View {
        HStack {
            
            // Product image
            #if DEBUG
            Image(product.name).resizable().aspectRatio(contentMode: .fit).padding()
            #else
            RemoteImage(url: API.images.rawValue + product.imageURL)
                .shadow(radius: 10).padding()
            #endif
            
            // Info
            VStack(alignment: .leading) {
                Text(product.name).font(.title2).fontWeight(.medium)
                
                Text("\(product.price, specifier: "%.2f") €").font(.title3)
                
                Text(product.available ? "Disponibile" : "Esaurito").foregroundColor(product.available ? .green : .red)
                    .padding(.vertical, 10)
            }
        }
        .padding()
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product.mocks[1])
            
    }
}
