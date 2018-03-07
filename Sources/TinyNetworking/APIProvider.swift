//
//  APIProvider.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case error(Error)
}

public enum APIError: Error {
    case emptyResult
    case decodingFailed
    case requestFailed(withStatusCode: Int)
}

public class APIProvider {

    public init() {}
    public func request<Body, Response>(_ resource: Resource<Body, Response>,
                                        session: URLSession = URLSession.shared,
                                        completion: @escaping (Result<Response>) -> Void) {

        let request = URLRequest(resource: resource)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.error(error ?? APIError.emptyResult))
                return
            }
            if let response = response as? HTTPURLResponse {
                guard 200..<300 ~= response.statusCode else {
                    completion(.error(APIError.requestFailed(withStatusCode: response.statusCode)))
                    return
                }
            }
            guard let result = resource.decode(data) else {
                completion(.error(APIError.decodingFailed))
                return
            }

            completion(.success(result))
            }
            .resume()
    }
}

