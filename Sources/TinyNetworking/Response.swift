//
//  Response.swift
//  TinyNetworking
//
//  Created by Joan Disho on 30.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public final class Response: CustomDebugStringConvertible {
    public let urlRequest: URLRequest
    public let data: Data?
    public let httpURLResponse: HTTPURLResponse?

    public var description: String {
        return """
        Requested URL: \(urlRequest.url?.absoluteString ?? "nil"),
        Status Code: \(httpURLResponse?.statusCode ?? -999),
        Data Count: \(data?.count ?? -999)
        """
    }

    public var debugDescription: String {
        return description
    }

    public var prettyJSONString: NSString? {
        return data?.prettyJSONString
    }

    public var json: Any? {
        return data?.json
    }

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

private extension Data {
    var prettyJSONString: NSString? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            else { return nil }

        return NSString(data: prettyPrintedData, encoding: String.Encoding.utf8.rawValue)
    }

    var json: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
    }
}

