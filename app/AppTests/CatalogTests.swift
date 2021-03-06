// CatalogTests.swift
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

import XCTest
import Alamofire
import StatusAlert

class CatalogTests: XCTestCase {

    func testProducts() throws {
        
        // Test async expectation
        let e = expectation(description: "Get products")
        
        AF.request(API.getAllProducts.rawValue, method: .get)
            .response { response in
                
                debugPrint(response)
                
                do {
                    
                    // Parse user info as JSON to Swift struct
                    let _ = try JSONDecoder().decode([Product].self, from: response.data!)
                    XCTAssert(true)
                    e.fulfill()
                    
                } catch {
                    XCTAssert(false)
                    print(error)
                    e.fulfill()
                }
            }
        
        // Wait for asynchronous api call
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testCategories() throws {
        
        // Test async expectation
        let e = expectation(description: "Get categories")
        
        AF.request(API.getCategories.rawValue, method: .get)
            .response { response in
                
                debugPrint(response)
                
                do {
                    
                    // Parse user info as JSON to Swift struct
                    let _ = try JSONDecoder().decode([Category].self, from: response.data!)
                    XCTAssert(true)
                    e.fulfill()
                    
                } catch {
                    XCTAssert(false)
                    e.fulfill()
                }
            }
        
        // Wait for asynchronous api call
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

}
