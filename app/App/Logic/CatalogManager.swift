// CatalogManager.swift
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
import SwiftUI

class CatalogManager: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    
    init() {
        #if DEBUG
        self.products = Product.mocks
        self.categories = Category.mocks
        #endif
    }
    
    func fetchProducts() {
        
    }
    
    func searchProducts(for name: String) {
        
    }
    
    func fetchCategory(for category: String) {
        
    }
    
}
