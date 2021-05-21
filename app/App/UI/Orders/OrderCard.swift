// OrderCard.swift
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

struct OrderCard: View {
    
    // MARK: - View properties
    let order: Order
    
    // MARK: - View body
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Ordine n. #\(order.id)").fontWeight(.semibold).font(.title).foregroundColor(.darkBlue)
            
            Label("\(order.delivery)", systemImage: "bus").font(.title2).foregroundColor(.darkBlue).padding(.vertical, 5)
            
            Text(order.state).foregroundColor(orderStateColor(for: order.state)).fontWeight(.semibold)
                .font(.title3)
                .padding(.vertical, 5)

        }
    }
    
}


/// Return the corresponding color of the order's state
/// - Parameter state: order's state
/// - Returns: SwiftUI Color
func orderStateColor(for state: String) -> Color {
   switch state {
   case "In attesa di pagamento": return Color.red
   case "Pagamento ricevuto": return Color.orange
   case "In elaborazione": return Color.yellow
   case "Spedito": return Color.green
   case "In consegna": return Color.green
   case "Consegnato": return Color.green
   default: return Color.gray
   }
}

// SwiftUI debugging preview
struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        OrderCard(order: Order.mocks[0])
    }
}
