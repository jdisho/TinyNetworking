//
//  TinyNetworking.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public enum Error: Swift.Error {
    case error(Swift.Error?)
    case emptyResult
    case decodingFailed(Swift.Error?)
    case noHttpResponse
    case requestFailed(Data)
}

public class TinyNetworking<R: Resource>: TinyNetworkingType {

    public init() {}

    @discardableResult
    public func request(
        resource: R,
        session: TinyNetworkingSession = URLSession.shared,
        queue: DispatchQueue = .main,
        completion: @escaping (Result<Response, Error>) -> Void
        ) -> URLSessionDataTask {
        let request = URLRequest(resource: resource)
        return session.loadData(with: request, queue: queue) { data, response, error in
            guard error == nil else {
                completion(.failure(.error(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyResult))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noHttpResponse))
                return
            }
            guard 200..<300 ~= response.statusCode else {
                completion(.failure(.requestFailed(data)))
                return
            }

            completion(.success(Response(urlRequest: request, data: data)))
        }
    }
}

