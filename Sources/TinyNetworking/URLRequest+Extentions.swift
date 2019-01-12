//
//  URLRequest+Extentions.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

internal extension URLRequest {
    init(resource: ResourceType) {
        var url = resource.baseURL.appendingPathComponent(resource.endpoint.path)

        if case let .requestWithParameters(parameters, encoding) = resource.task {
            url = url.appendingQueryParameters(parameters, encoding: encoding)
        }

        self.init(url: url)

        httpMethod = resource.endpoint.method.rawValue

        for (key, value) in resource.headers {
            addValue(value, forHTTPHeaderField: key)
        }

        if resource.endpoint.method == .post || resource.endpoint.method == .put {
            if case let .requestWithEncodable(encodable) = resource.task {
                let anyEncodable = AnyEncodable(encodable)
                httpBody = encode(object: anyEncodable)
            }
        }
    }

    func encode<E>(object: E) -> Data? where E : Encodable {
        return try? JSONEncoder().encode(object)
    }
}

