// UserManagerTests.swift
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

class UserManagerTests: XCTestCase {

    func testLogin() throws {
        // Test async expectation
        let e = expectation(description: "Login request")
        
        let email = "alessiorubicini16@icloud.com"
        let password = "0eaafad89f3c33e452923e6a9e29a226"
        
        AF.request(API.login.rawValue, method: .post, parameters: ["email": email, "password": password])
            .response { response in
                
                do {
                    // Parse user info as JSON to Swift struct
                    let _ = try JSONDecoder().decode(User.self, from: response.data!)
                    XCTAssert(true)
                    e.fulfill()
                } catch {
                    print(error)
                    XCTAssert(false)
                    e.fulfill()
                }
                
            }
        
        // Wait for asynchronous api call
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
    }

}
