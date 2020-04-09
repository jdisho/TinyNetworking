//
//  Extensions.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 09/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import Combine
import XCTest

@available(iOS 13.0, *)
extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}

extension Result where Success: Equatable {
    func assertSuccess(value: Success, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(resultValue):
            XCTAssertEqual(resultValue, value, file: file, line: line)
        case let .failure(error):
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        }
    }
}

extension Result {
    func assertFailure(_ message: String, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(value):
            XCTFail("Unexpected success: \(value)", file: file, line: line)
        case let .failure(error):
            XCTAssertEqual(error.localizedDescription, message, file: file, line: line)
        }
    }
}
