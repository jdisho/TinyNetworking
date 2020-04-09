//
//  FooResource.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 09/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import Foundation
import TinyNetworking

enum FooResource {
    case getEndpoint
    case postEndpoint
}

extension FooResource: Resource {
    var baseURL: URL {
        return URL(string: "https://mocky.io")!
    }
    
    var endpoint: Endpoint {
        switch self {
        case .getEndpoint:
            return .get(path: "/getEndpoint")
        case .postEndpoint:
            return .post(path: "/postEndpoint")
        }
    }
    
    var task: Task {
        switch self {
        case .getEndpoint:
            return .requestWithParameters(["foo": "bar"], encoding: URLEncoding())
        case .postEndpoint:
            return .requestWithEncodable(FooEncodable())
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": "Bearer xxx"]
    }
}
