// API.swift
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

// HTTP API resource paths
enum API: String {
    
    // User
    case login = "http://localhost:8888/GameZen/api/users/login.php"
    case register = "http://localhost:8888/GameZen/api/users/register.php"
    case getCart = "http://localhost:8888/GameZen/api/users/getCart.php"
    
    // Catalog
    case getAllProducts = "http://localhost:8888/GameZen/api/catalog/get.php"
    case getCategories = "http://localhost:8888/GameZen/api/catalog/getCategories.php"
    case images = "http://localhost:8888/GameZen/api/images/"
    
    // Orders
    case getOrders = "http://localhost:8888/GameZen/api/orders/get.php"
    case postOrder = "http://localhost:8888/GameZen/api/orders/post.php"
    
    // Addresses
    
}
