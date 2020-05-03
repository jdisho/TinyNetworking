//
//  EndpointTests.swift
//  TinyNetworkingTests
//
//  Created by Alan Steiman on 08/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class EndpointTests: XCTestCase {
    
    func test_method_success() {
        XCTAssertEqual(Endpoint.put(path: "foo").method.rawValue, "PUT")
        XCTAssertEqual(Endpoint.get(path: "foo").method.rawValue, "GET")
        XCTAssertEqual(Endpoint.post(path: "foo").method.rawValue, "POST")
        XCTAssertEqual(Endpoint.delete(path: "foo").method.rawValue, "DELETE")
    }
    
    func test_path_success() {
        XCTAssertEqual(Endpoint.put(path: "foo").path, "foo")
        XCTAssertEqual(Endpoint.get(path: "foo").path, "foo")
        XCTAssertEqual(Endpoint.post(path: "foo").path, "foo")
        XCTAssertEqual(Endpoint.delete(path: "foo").path, "foo")
    }
    
    func test_defaultParamDestination_success() {
        XCTAssertEqual(Endpoint.get(path: "foo").defaultParamDestination, ParamDestination.urlQuery)
        XCTAssertEqual(Endpoint.post(path: "foo").defaultParamDestination, ParamDestination.httpBody)
        XCTAssertEqual(Endpoint.put(path: "foo").defaultParamDestination, ParamDestination.httpBody)
        XCTAssertEqual(Endpoint.delete(path: "foo").defaultParamDestination, ParamDestination.httpBody)
    }
}
