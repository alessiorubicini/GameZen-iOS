// DangerousActionView.swift
// AddressesView.swift
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
import CryptoKit

// This view displays a input field to confirm the account cancelation
// It's used when the biometric authentication is not available on the user device
struct DeleteAccountView: View {
    
    // MARK: - View properties
    
    @EnvironmentObject private var state: AppState
    @Environment(\.presentationMode) var presentationMode

    @State private var password = ""
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            
            Text("Inserisci la password per confermare l'eliminazione dell'account\n\nL'operazione è irreversibile")
                .foregroundColor(.darkBlue)
                .multilineTextAlignment(.center)
            
            TextField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                
                // Generate the password MD5 hash
                var hashedPassw = Insecure.MD5.hash(data: password.data(using: .utf8)!).description.split(separator: ":")[1]
                hashedPassw.remove(at: hashedPassw.startIndex)
                
                // Check if the password is correct
                if hashedPassw != self.state.user!.password {
                    return
                }
                
                // Delete the account
                self.state.deleteAccount()
                
                // Dismiss the view
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Conferma eliminazione")
            }).buttonStyle(RedButton())
            
        }
    }
}

// SwiftUI debugging preview
struct DangerousActionView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
            .environmentObject(AppState())
    }
}
