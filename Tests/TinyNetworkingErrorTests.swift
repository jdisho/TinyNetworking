//
//  TinyNetworkingErrorTests.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 07/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import XCTest
@testable import TinyNetworking

class TinyNetworkingErrorTests: XCTestCase {
    
    let expectedResponse = Response(urlRequest: URLRequest(url: URL(string: "https://mocky.io")!), data: Data(base64Encoded: "response"), httpURLResponse: nil)
    
    func test_response_success() {
        XCTAssertEqual(TinyNetworkingError.noData(expectedResponse).response, expectedResponse)
        
        XCTAssertEqual(TinyNetworkingError.statusCode(expectedResponse).response, expectedResponse)
        
        XCTAssertEqual(TinyNetworkingError.decoding(FooError.someError, expectedResponse).response, expectedResponse)
        
        XCTAssertEqual(TinyNetworkingError.underlying(FooError.someError, expectedResponse).response, expectedResponse)
    }
    
    func test_errorDescription_success() {
        XCTAssertEqual(TinyNetworkingError.noData(expectedResponse).errorDescription, "The request gave no data.")
        
        XCTAssertEqual(TinyNetworkingError.statusCode(expectedResponse).errorDescription, "Status code didn\'t fall within the given range.")
        
        XCTAssertEqual(TinyNetworkingError.decoding(FooError.someError, expectedResponse).errorDescription, "Failed to map data to a Decodable object.")
        
        XCTAssertEqual(TinyNetworkingError.underlying(FooError.someError, expectedResponse).errorDescription, "The operation couldn’t be completed. (TinyNetworkingTests.FooError error 0.)")
    }
}

extension Response: Equatable {
    public static func == (lhs: Response, rhs: Response) -> Bool {
        return lhs.data == rhs.data &&
            lhs.urlRequest == rhs.urlRequest &&
            lhs.httpURLResponse == rhs.httpURLResponse
    }
}
