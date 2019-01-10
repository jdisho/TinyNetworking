//
//  HTTPMethod.swift
//  TinyNetworking
//
//  Created by Joan Disho on 31.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

internal enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum Endpoint {
    case get(String)
    case post(String)
    case put(String)
    case delete(String)

    internal var path: String {
        switch self {
        case let .get(path),
             let .post(path),
             let .put(path),
             let .delete(path):
            return path
        }
    }

    internal var method: HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .delete:
            return HTTPMethod.delete
        }
    }
}
