// ShareLogic.swift
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

import Foundation
import UIKit

// These functions are used to display a share sheet to share some information through other apps

func shareApp() {
    let shared = "Scarica GameZen per iOS!"
    
    let activityVC = UIActivityViewController(activityItems: [shared], applicationActivities: nil)
    
    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
}

func shareProduct(product: Product) {
    let shared = "Controlla il gioco \(product.name) su GameZen al prezzo di \(product.price) €"
    
    let activityVC = UIActivityViewController(activityItems: [shared], applicationActivities: nil)
    
    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
}
