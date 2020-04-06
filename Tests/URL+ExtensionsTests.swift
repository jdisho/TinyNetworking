//
//  URL+ExtensionsTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 06/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class URLExtensionsTests: XCTestCase {
    
    func test_appendingQueryParameters_withoutParameters() {
        let url = URL(string: "https://www.google.com")!
        
        let result = url.appendingQueryParameters([:], encoding: URLEncoding())
        
        XCTAssertEqual(result.absoluteString, "https://www.google.com?")
    }
    
    func test_appendingQueryParameters_withParameters() {
        let url = URL(string: "https://www.google.com")!
        
        let result = url.appendingQueryParameters(["foo": "bar", "baz": "qux"], encoding: URLEncoding())
        
        XCTAssertEqual(result.absoluteString, "https://www.google.com?baz=qux&foo=bar")
    }
    
    func test_appendingQueryParameters_withExistingQuery() {
        let url = URL(string: "https://www.google.com?baz=qux")!
        
        let result = url.appendingQueryParameters(["foo": "bar"], encoding: URLEncoding())
        
        XCTAssertEqual(result.absoluteString, "https://www.google.com?baz=qux&foo=bar")
    }
}
