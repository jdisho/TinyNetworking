//
//  ResponseTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 08/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class ResponseTests: XCTestCase {
    
    func test_description_withValues() {
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let data = Data(base64Encoded: "data")
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse)
        
        XCTAssertEqual(response.description, "Requested URL: https://mocky.io/getEndpoint?foo=bar,\nStatus Code: 200,\nData Count: 3")
    }
    
    func test_description_withEmpty() {
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let response = Response(urlRequest: request, data: nil, httpURLResponse: nil)
        
        XCTAssertEqual(response.description, "Requested URL: https://mocky.io/getEndpoint?foo=bar,\nStatus Code: -999,\nData Count: -999")
    }
    
    func test_debugDescription_success() {
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let data = Data(base64Encoded: "data")
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse)
        
        XCTAssertEqual(response.debugDescription, "Requested URL: https://mocky.io/getEndpoint?foo=bar,\nStatus Code: 200,\nData Count: 3")
    }
    
    func test_prettyJSON_success() {
        let data = FooEncodable().data
        
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse)
        
        XCTAssertEqual(response.prettyJSONString, "{\n  \"params\" : {\n    \"foo\" : \"bar\"\n  }\n}")
    }
    
    func test_json_success() {
        let data = FooEncodable().data
        
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse)
        
        let json = response.json
        
        let decodedData = try! JSONSerialization.data(withJSONObject: json!, options: .fragmentsAllowed)
        
        XCTAssertEqual(decodedData, data)
    }
    
    func test_mapTo_success() {
        let fooInstance = FooEncodable()
        let data = fooInstance.data
        
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse)
        
        XCTAssertEqual(try! response.map(to: FooEncodable.self), fooInstance)
    }
    
    func test_mapTo_error_noData() {
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: nil, httpURLResponse: httpURLResponse)
        
        XCTAssertThrowsError(try response.map(to: FooEncodable.self), "Should throw error") { error in
            if case let TinyNetworkingError.noData(returnedResponse) = error {
                XCTAssertEqual(response, returnedResponse)
            } else {
                XCTFail("Error type mismatch")
            }
        }
    }
    
    func test_mapTo_error_decoding() {
        let request = URLRequest(resource: FooResource.getEndpointQueryParams)
        let data = FooEncodable().data
        
        let httpURLResponse = HTTPURLResponse(url: URL(string: "https://mocky.io")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = Response(urlRequest: request, data: data, httpURLResponse: httpURLResponse)
        
        XCTAssertThrowsError(try response.map(to: BarEncodable.self), "Should throw error") { error in
            if case let TinyNetworkingError.decoding(returnedError, returnedResponse) = error {
                XCTAssertEqual(response, returnedResponse)
                XCTAssertEqual(returnedError.localizedDescription, "The data couldn’t be read because it is missing.")
            } else {
                XCTFail("Error type mismatch")
            }
        }
    }
}
