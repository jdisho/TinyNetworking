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
