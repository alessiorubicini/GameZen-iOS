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
    case login = "http://localhost:8888/GameZen/api/user/login.php"
    case register = "http://localhost:8888/GameZen/api/user/register.php"
    
    // Catalog
    case getProduct = "http://localhost:8888/GameZen/api/catalog/get.php"
    case getAllProducts = "http://localhost:8888/GameZen/api/catalog/getAll.php"
    case getByCategory = "http://localhost:8888/GameZen/api/catalog/getByCategory.php"
    case search = "http://localhost:8888/GameZen/api/catalog/search.php"
    
    // Orders
    case getOrder = "http://localhost:8888/GameZen/api/orders/get.php"
    case getAllOrders = "http://localhost:8888/GameZen/api/orders/getAll.php"
    case postOrder = "http://localhost:8888/GameZen/api/orders/post.php"
    
}
