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
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://mocky.io/getEndpoint?foo=bar")
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.useProtocolCachePolicy)
        XCTAssertEqual(request.allHTTPHeaderFields, ["Authorization": "Bearer xxx"])
    }
    
    func test_init_postEndpoint_success() {
        let request = URLRequest(resource: FooResource.postEndpoint)
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://mocky.io/postEndpoint")
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.useProtocolCachePolicy)
        XCTAssertEqual(request.httpBody, FooEncodable().data)
    }
    
    func test_encode_success() {
        let fooInstance = FooEncodable()
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        XCTAssertEqual(request.encode(object: fooInstance), fooInstance.data)
    }
    
    func test_destination_httpBody() {
        let request = URLRequest(resource: FooResource.getEndpointHttpBody)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://mocky.io/getEndpoint")
        XCTAssertEqual(request.httpBody, "foo=bar".data(using: .utf8))
    }
    
    func test_defaultGetParamDestination_urlQuery() {
        let request = URLRequest(resource: FooResource.getEndpointNoDestination)
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://mocky.io/getEndpoint?foo=bar")
    }
    
    func test_defaultPostParamDestination_httpBody() {
        let request = URLRequest(resource: FooResource.postEndpointNoDestination)
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.absoluteString, "https://mocky.io/postEndpoint")
        XCTAssertEqual(request.httpBody, "foo=bar".data(using: .utf8))
    }
}
