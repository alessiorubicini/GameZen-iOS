// CustomButton.swift
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

import Foundation
import SwiftUI

// Custom blue button for the app
// Indicates a generic action
struct BlueButton: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(isEnabled ? .white : .gray)
            .padding()
            .frame(width: 290)
            .background(isEnabled ? Color.bluePrimary : Color.darkBlue)
            .cornerRadius(25)
            .shadow(color: isEnabled ? .bluePrimary : .darkBlue, radius: 5)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeOut(duration: 0.2))
                
    }
}

// Custom red button for the app
// Indicates a dangerous action
struct RedButton: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(isEnabled ? .white : .gray)
            .padding()
            .frame(width: 290)
            .background(Color.lightRed)
            .cornerRadius(25)
            .shadow(color: .lightRed, radius: 5)
            
                
    }
}

// SwiftUI preview for debugging
struct CustomButton_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            Button(action: {
                
            }, label: {
                Text("Invia ordine")
            }).buttonStyle(BlueButton())
            .disabled(true)
            
            Button(action: {
                
            }, label: {
                Text("Invia ordine")
            }).buttonStyle(BlueButton())
            
        }
        
    }
    
}
