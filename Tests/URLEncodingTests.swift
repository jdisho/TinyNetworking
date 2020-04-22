//
//  URLEncodingTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 08/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class URLEncodingTests: XCTestCase {
    
    func test_arrayEncoding_encode_brackets() {
        let encoding = URLEncoding(destination: .urlQuery)
        let encoded = encoding.arrayEncoding.encode(key: "foo")
        XCTAssertEqual(encoded, "foo[]")
    }
    
    func test_arrayEncoding_encode_noBrackets() {
        let encoding = URLEncoding(destination: .urlQuery, arrayEncoding: .noBrackets)
        let encoded = encoding.arrayEncoding.encode(key: "foo")
        XCTAssertEqual(encoded, "foo")
    }
    
    func test_boolEncoding_encode_literal_true() {
        let encoding = URLEncoding(destination: .urlQuery)
        let encoded = encoding.boolEncoding.encode(flag: true)
        XCTAssertEqual(encoded, "true")
    }
    
    func test_boolEncoding_encode_numeric_true() {
        let encoding = URLEncoding(destination: .urlQuery, boolEncoding: .numeric)
        let encoded = encoding.boolEncoding.encode(flag: true)
        XCTAssertEqual(encoded, "1")
    }
    
    func test_boolEncoding_encode_literal_false() {
        let encoding = URLEncoding(destination: .urlQuery)
        let encoded = encoding.boolEncoding.encode(flag: false)
        XCTAssertEqual(encoded, "false")
    }
    
    func test_boolEncoding_encode_numeric_false() {
        let encoding = URLEncoding(destination: .urlQuery, boolEncoding: .numeric)
        let encoded = encoding.boolEncoding.encode(flag: false)
        XCTAssertEqual(encoded, "0")
    }
    
    func test_query_success() {
        let encoding = URLEncoding(destination: .urlQuery)
        let query = encoding.query(
            [
                "foo": "bar",
                "baz": "qux",
                "bool": true,
                "dictionary": [
                    "foo": "bar"
                ],
                "array": ["1", "2", "3"]
            ]
        )
        XCTAssertEqual(query, "array[]=1&array[]=2&array[]=3&baz=qux&bool=true&dictionary[foo]=bar&foo=bar")
    }
}
