//
//  URLSession+ExtensionsTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 09/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class URLSessionExtensionsTests: XCTestCase {
        
    func test_loadData_success() {
        let expectation = XCTestExpectation()
        _ = URLSession.mocked.loadData(with: URLRequest(resource: FooResource.getEndpoint), queue: .main) { (response, error) in
            XCTAssertEqual(response.data, FooEncodable().data)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
