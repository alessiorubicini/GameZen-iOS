// OrderTests.swift
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

import XCTest
import Alamofire

class OrderTests: XCTestCase {

    func testMakeOrder() {
        
        // Test async expectation
        let e = expectation(description: "Order POST request")
        
        let body: [String:Any] = ["userID": 1, "date": "2021-05-07", "delivery": "2021-05-10", "address": 1, "total": 50.00, "products": Product.mocks.map{$0.id}]
        
        // Send order to database through API
        AF.request(API.postOrder.rawValue, method: .post, parameters: body)
            .response { response in
                
                debugPrint(response)
                
                if let statusCode = response.response?.statusCode {
                    
                    if statusCode == 200 {
                        
                        XCTAssert(true)
                        e.fulfill()
                        
                    } else {
                        
                        XCTAssert(false)
                        e.fulfill()
                        
                    }
                    
                }
                
            }
        
        // Wait for asynchronous api call
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
    }

}
