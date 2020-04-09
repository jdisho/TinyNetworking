//
//  URLRequest+ExtensionsTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 09/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class URLRequestExtensionsTests: XCTestCase {
    
    func test_init_getEndpoint_success() {
        let request = URLRequest(resource: FooResource.getEndpoint)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://api.unsplash.com/getEndpoint?foo=bar")
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.useProtocolCachePolicy)
        XCTAssertEqual(request.allHTTPHeaderFields, ["Authorization": "Bearer xxx"])
    }
    
    func test_init_postEndpoint_success() {
        let request = URLRequest(resource: FooResource.postEndpoint)
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://api.unsplash.com/postEndpoint")
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.useProtocolCachePolicy)
        XCTAssertEqual(request.httpBody, FooEncodable().data)
    }
    
    func test_encode_success() {
        let fooInstance = FooEncodable()
        let request = URLRequest(resource: FooResource.getEndpoint)
        XCTAssertEqual(request.encode(object: fooInstance), fooInstance.data)
    }
}
