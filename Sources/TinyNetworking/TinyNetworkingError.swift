//
//  TinyNetworkingError.swift
//  TinyNetworking
//
//  Created by Joan Disho on 12.09.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

import Foundation

public enum TinyNetworkingError: Swift.Error {
    case noData
    case statusCode(Response)
    case decoding(Swift.Error?)
    case underlying(Swift.Error?)
}

extension TinyNetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "The request gave no data."
        case .statusCode:
            return "Status code didn't fall within the given range."
        case .decoding:
            return "Failed to map data to a Decodable object."
        case let .underlying(error):
            return error?.localizedDescription
        }
    }
}
