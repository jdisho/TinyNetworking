//
//  Resource.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public struct Resource<Body, Response> {
    let url: URL
    let token: String?
    let method: HttpMethod<Data?>
    let decode: (Data) -> Response?
    let parameters: [URLQueryItem]?
}

public extension Resource {
    init(url: URL,
         token: String? = nil,
         method: HttpMethod<Body> = .get,
         parameters: [URLQueryItem]? = nil,
         decode: @escaping (Any) -> Response?) {

        self.url = url
        self.method =  method.map { json in
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        }
        self.token = token
        self.decode = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonResponse = json as? Response else { return nil }
            return jsonResponse
        }
        self.parameters = parameters
    }
}

public extension Resource where Body: Encodable, Response: Decodable {
    init(url: URL,
         token: String? = nil,
         method: HttpMethod<Body> = .get,
         parameters: [URLQueryItem]? = nil) {

        self.url = url
        self.method =  method.map { try? JSONEncoder().encode($0) }
        self.token = token
        self.decode = {  try? JSONDecoder().decode(Response.self, from: $0) }
        self.parameters = parameters
    }
}

public extension Resource where Body == Void, Response: Decodable {
    init(url: URL,
         token: String? = nil,
         method: HttpMethod<Body> = .get,
         parameters: [URLQueryItem]? = nil) {

        self.url = url
        self.method =  method.map { _ in return nil }
        self.token = token
        self.decode = { try? JSONDecoder().decode(Response.self, from: $0) }
        self.parameters = parameters
    }
}

public typealias SimpleResource<Response> = Resource<Void, Response>

