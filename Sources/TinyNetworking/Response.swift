//
//  Response.swift
//  TinyNetworking
//
//  Created by Joan Disho on 30.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public final class Response {
    public let urlRequest: URLRequest
    public let data: Data?
    public let httpURLResponse: HTTPURLResponse?

    public init(
        urlRequest: URLRequest,
        data: Data?,
        httpURLResponse: HTTPURLResponse?
    ) {
        self.urlRequest = urlRequest
        self.data = data
        self.httpURLResponse = httpURLResponse
    }

    public func map<D: Decodable>(
        to type: D.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> D {
        guard let data = data else { throw TinyNetworkingError.noData(self) }

        do {
            return try decoder.decode(type, from: data)
        } catch(let error) {
            throw TinyNetworkingError.decoding(error, self)
        }
    }
}

