// OnboardingView.swift
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

// This view welcomes the user at the first launch
// It presents a list of the app's features
struct OnboardingView: View {
    
    // MARK: - View properties
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            Spacer()
            
            // App description
            VStack(alignment: .center) {
                
                Image("Icon-NoBG").resizable().aspectRatio(contentMode: .fit).frame(height: 150)
                    .padding(.vertical, 20)
                
                Text("Benvenuto/a!")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(.bluePrimary)
                
                Text("GameZen è un negozio online per l'acquisto di giochi da tavolo in modo veloce e sicuro!")
                    .fontWeight(.medium)
                    .foregroundColor(.darkBlue)
                    .padding()
                    .multilineTextAlignment(.center)
                
            }
            
            // App features
            VStack(alignment: .leading) {
                OnboardingDetail(image: "greetingcard.fill", title: "Ampio catalogo", description: "Un ampio catalogo con gli ultimi giochi sul mercato.")
                OnboardingDetail(image: "cart.fill", title: "Orientato all'utente", description: "Salva articoli che ami nel carrello e traccia gli ordini effettuati.")
                OnboardingDetail(image: "laptopcomputer.and.iphone", title: "Disponibile ovunque", description: "GameZen è disponibile su iOS, Android e via web.")
            }
            
            Spacer()
            
            Button("Avanti") {
                
                // Set onboarding value
                UserDefaults.standard.setValue(false, forKey: "isFirstLaunch")
                
                // Dismiss sheet view
                self.presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(BlueButton())
        }
        .onDisappear {
            // Set onboarding value
            UserDefaults.standard.setValue(false, forKey: "isFirstLaunch")
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
