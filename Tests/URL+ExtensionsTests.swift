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
        // Given
        let url = URL(string: "https://mocky.io")!
        
        // When
        let result = url.appendingQueryParameters([:], encoding: URLEncoding(destination: .urlQuery))
        
        // Then
        XCTAssertEqual(result.absoluteString, "https://mocky.io?")
    }
    
    func test_appendingQueryParameters_withParameters() {
        // Given
        let url = URL(string: "https://mocky.io")!
        
        // WHen
        let result = url.appendingQueryParameters(["foo": "bar", "baz": "qux"], encoding: URLEncoding(destination: .urlQuery))
        
        // Then
        XCTAssertEqual(result.absoluteString, "https://mocky.io?baz=qux&foo=bar")
    }
    
    func test_appendingQueryParameters_withExistingQuery() {
        // Given
        let url = URL(string: "https://mocky.io?baz=qux")!
        
        // When
        let result = url.appendingQueryParameters(["foo": "bar"], encoding: URLEncoding(destination: .urlQuery))
        
        // Then
        XCTAssertEqual(result.absoluteString, "https://mocky.io?baz=qux&foo=bar")
    }
}
