// FAQView.swift
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

struct FAQView: View {
    
    // MARK: - View properties
    
    @State private var whatIs = false
    @State private var buying = false
    @State private var orders = false
    @State private var address = false
    
    // MARK: - View body
    
    var body: some View {
        List {
            
            DisclosureGroup("Cos'è GameZen?", isExpanded: $whatIs) {
                Text("GameZen è un negozio online di giochi da tavolo")
            }
            
            DisclosureGroup("Come si acquista un gioco?", isExpanded: $buying) {
                Text("Per acquistare un gioco seleziona uno o più prodotti dal catalogo e aggiungili al carrello. Una volta aggiunti, vai nel carrello per scegliere l'indirizzo di consegna e conferma l'ordine.")
            }
            
            DisclosureGroup("Come tracciare gli ordini effettuati?", isExpanded: $orders) {
                Text("Per tracciare gli ordini già effettuati, visita la sezione 'Ordini' nel tuo profilo utente. Qui potrai visionare gli ordini effettuati e il loro stato con tutte le informazioni necessarie. Puoi anche annullare un ordine prima che sia spedito.")
            }
            
            DisclosureGroup("Come gestire gli indirizzi di consegna?", isExpanded: $address) {
                Text("Per gestire i tuoi indirizzi di consegna, visita la sezione 'Indirizzi' nel tuo profilo utente nella quale puoi aggiungere ed eliminare indirizzi. Quando effettui un ordine, devi necessariamente scegliere un indirizzo di consegna.")
            }
            
        }.listStyle(InsetGroupedListStyle())
    }
}

// SwiftUI debugging preview
struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FAQView()
                .navigationTitle("F.A.Q.")
        }
    }
}
