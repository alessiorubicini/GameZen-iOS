// OrderView.swift
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

struct OrderView: View {
    
    // MARK: - View properties
    @EnvironmentObject private var state: AppState
    
    let order: Order
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            
            // Order info
            Group {
                Text(order.state).foregroundColor(orderStateColor(for: order.state))
                
                Divider()
                
                Text("Data dell'ordine: \(order.date)")
                
                Divider()
                
                Text("Stima consegna: \(order.delivery)")
                
                Divider()
                
                Text("Totale: \(order.total, specifier: "%.2f") €")
            }
            
            Button("Annulla Ordine") {
                
                if order.state == "In attesa di pagamento" || order.state == "Pagamento ricevuto" || order.state == "In elaborazione" {
                    self.state.cancelOrder(of: order.id)
                } else {
                    self.state.alert = (true, "Errore", "Non puoi annullare un ordine già spedito dall'app. Per un rimborso contatta il supporto clienti")
                }
                
            }.buttonStyle(RedButton())
            .padding(.top, 20)
            
            // Order products
            
            List {
                
                ForEach(self.order.products) { product in
                    ProductCard(product: product).frame(height: 150)
                }


            }
            .listStyle(PlainListStyle())
            
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OrderView(order: Order.mocks[0])
                .navigationTitle("Ordine n.#\(Order.mocks[0].id)")
                .environmentObject(AppState())
        }
    }
}
