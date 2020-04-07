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
    
    func test_init_notNil() {
        let instance = TinyNetworking<FooResource>()
        
        XCTAssertNotNil(instance)
    }
    
    func test_request_failure_underlyingError() {
        let instance = TinyNetworking<FooResource>()
        let mockSession = MockSession(input: MockSession.Input(data: nil, httpURLResponse: nil, error: FooError.random))
        instance.request(resource: .someEndpoint, session: mockSession, queue: .main) { result in
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
        let instance = TinyNetworking<FooResource>()
        let mockSession = MockSession(input: MockSession.Input(data: nil, httpURLResponse: HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil), error: nil))
        instance.request(resource: .someEndpoint, session: mockSession, queue: .main) { result in
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
        let instance = TinyNetworking<FooResource>()
        let mockSession = MockSession(input: MockSession.Input(data: returnData, httpURLResponse: HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil))
        instance.request(resource: .someEndpoint, session: mockSession, queue: .main) { result in
            switch result {
            case let .success(response):
                XCTAssertEqual(response.data, returnData)
            case .failure(_):
                XCTFail("Unexpected error response")
            }
        }
    }
}

enum FooError: Swift.Error {
    case random
}

class MockSession: TinyNetworkingSession {
    
    struct Input {
        let data: Data?
        let httpURLResponse: HTTPURLResponse?
        let error: Swift.Error?
    }
    
    private let input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    func loadData(with urlRequest: URLRequest, queue: DispatchQueue, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        
        completionHandler(Response(urlRequest: urlRequest, data: input.data, httpURLResponse: input.httpURLResponse), input.error)
        return URLSessionDataTask()
    }
}

enum FooResource {
    case someEndpoint
}

extension FooResource: Resource {
    var baseURL: URL {
       return URL(string: "https://api.unsplash.com")!
     }
     
     var endpoint: Endpoint {
       switch self {
       case .someEndpoint:
         return .get(path: "/someEndpoint")
       }
     }
    
     var task: Task {
       var params: [String: Any] = [:]
       return .requestWithParameters(params, encoding: URLEncoding())
     }
     
     var headers: [String: String] {
       return ["Authorization": "Bearer xxx"]
     }
}
