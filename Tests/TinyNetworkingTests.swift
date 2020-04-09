//
//  TinyNetworkingTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 06/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class TinyNetworkingTests: XCTestCase {
    
    let network = TinyNetworking<FooResource>()
    
    func test_init_notNil() {
        XCTAssertNotNil(network)
    }
    
    func test_request_failure_underlyingError() {
        let mockSession = MockSession(input: MockSession.Input(data: nil, httpURLResponse: nil, error: FooError.random))
        network.request(resource: .someEndpoint, session: mockSession, queue: .main) { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected success response")
            case let .failure(error):
                if case let TinyNetworkingError.underlying(underlyingError, _) = error {
                    XCTAssertEqual(underlyingError as? FooError, FooError.random)
                } else {
                    XCTFail("Error type does not match")
                }
            }
        }
    }
    
    func test_request_failure_httpError() {
        let mockSession = MockSession(input: MockSession.Input(data: nil, httpURLResponse: HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil), error: nil))
        network.request(resource: .someEndpoint, session: mockSession, queue: .main) { result in
            switch result {
            case .success(_):
                XCTFail("Unexpected success response")
            case let .failure(error):
                if case let TinyNetworkingError.statusCode(response) = error {
                    XCTAssertEqual(response.httpURLResponse?.statusCode, 500)
                } else {
                    XCTFail("Error type does not match")
                }
            }
        }
    }
    
    func test_request_success() {
        let returnData = Data(base64Encoded: "response")
        let mockSession = MockSession(input: MockSession.Input(data: returnData, httpURLResponse: HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil))
        network.request(resource: .someEndpoint, session: mockSession, queue: .main) { result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.data, returnData)
            case .failure(_):
                XCTFail("Unexpected error response")
            }
        }
    }
}
