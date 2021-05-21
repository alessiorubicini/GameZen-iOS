// OrdersListView.swift
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

// This view displays a list of orders
struct OrdersListView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState

    let orders: [Order]
    
    // MARK: - View body
    
    var body: some View {
        
        if orders.count == 0 {
            
            Group {
                Image(systemName: "bag").foregroundColor(.bluePrimary).font(.system(size: 150))
                Text("Non hai effettuato alcun ordine").font(.title2).foregroundColor(.bluePrimary)
            }.padding(.vertical)
            
        } else {
            
            List {
                ForEach(orders) { order in
                    NavigationLink(destination: OrderView(order: order).environmentObject(self.state).navigationTitle("Ordine n. #\(order.id)")) {
                        OrderCard(order: order)
                    }
                }
            }.listStyle(InsetGroupedListStyle())
            
        }
        
    }
}

// SwiftUI debugging preview
struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrdersListView(orders: Order.mocks).navigationTitle("Ordini")
                .environmentObject(AppState())
        }
    }
}
