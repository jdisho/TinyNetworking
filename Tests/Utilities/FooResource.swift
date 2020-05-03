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
    case getEndpointQueryParams
    case getEndpointHttpBody
    case getEndpointNoDestination
    case postEndpoint
    case postEndpointNoDestination
}

extension FooResource: Resource {
    var baseURL: URL {
        return URL(string: "https://mocky.io")!
    }
    
    var endpoint: Endpoint {
        switch self {
        case .getEndpointQueryParams, .getEndpointHttpBody, .getEndpointNoDestination:
            return .get(path: "/getEndpoint")
        case .postEndpoint, .postEndpointNoDestination:
            return .post(path: "/postEndpoint")
        }
    }
    
    var task: Task {
        switch self {
        case .getEndpointQueryParams:
            return .requestWithParameters(["foo": "bar"], encoding: URLEncoding(destination: .urlQuery))
        case .getEndpointHttpBody:
            return .requestWithParameters(["foo": "bar"], encoding: URLEncoding(destination: .httpBody))
        case .getEndpointNoDestination:
            return .requestWithParameters(["foo": "bar"], encoding: URLEncoding())
        case .postEndpoint:
            return .requestWithEncodable(FooEncodable())
        case .postEndpointNoDestination:
            return .requestWithParameters(["foo": "bar"], encoding: URLEncoding())
        }
    }
    
    var headers: [String: String] {
        return ["Authorization": "Bearer xxx"]
    }
}
