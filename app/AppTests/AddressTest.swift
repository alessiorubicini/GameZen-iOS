// AddressTest.swift
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

class AddressTest: XCTestCase {

    func testLoadAddresses() throws {
        
        // Test async expectation
        let e = expectation(description: "Addresses GET request")
        
        // Send a GET request
        AF.request(API.getAddresses.rawValue + "?userID=1", method: .get)
            .response { response in

                debugPrint(response)
                
                do {
                    // Parse user info as JSON to Swift struct
                    let _ = try JSONDecoder().decode([Address].self, from: response.data!)
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
