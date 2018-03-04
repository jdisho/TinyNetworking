//
//  URLRequest+Extentions.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public extension URLRequest {

    init<Body, Response>(resource: Resource<Body, Response>) {
        var urlComponents = URLComponents(string: resource.url.absoluteString)
        urlComponents?.queryItems = resource.parameters

        self.init(url: urlComponents?.url ?? resource.url)

        httpMethod = resource.method.method

        if let token = resource.token {
            addValue(token, forHTTPHeaderField: "Authorization")
        }

        if case let .post(data) = resource.method {
            addValue("application/json", forHTTPHeaderField: "Content-Type")
            httpBody = data
        }
    }
}

