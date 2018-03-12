//
//  APIProvider.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public class APIProvider {

    public enum Result<T> {
        case success(T)
        case error(APIError)
    }

    public enum APIError: Error {
        case networkError(Error?)
        case emptyResult
        case decodingFailed(Error?)
        case noHttpResponse
        case requestFailed(statusCode: Int)
    }

    public init() {}

    @discardableResult func performRequest<Body, Response>(_ resource: Resource<Body, Response>,
                                                           session: URLSession = URLSession.shared,
                                                           completion: @escaping (Result<Response>) -> Void) -> URLSessionDataTask {
        let request = URLRequest(resource: resource)
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.error(APIError.networkError(error)))
                return
            }

            guard let data = data else {
                completion(.error(APIError.emptyResult))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.error(APIError.noHttpResponse))
                return
            }

            guard 200..<300 ~= response.statusCode else {
                completion(.error(APIError.requestFailed(statusCode: response.statusCode)))
                return
            }

            do {
                guard let result = try resource.decode(data) else {
                    completion(.error(APIError.decodingFailed(nil)))
                    return
                }

                completion(.success(result))
            } catch {
                completion(.error(APIError.decodingFailed(error)))
            }
        }

        dataTask.resume()
        return dataTask
    }

    public func request<Body, Response>(_ resource: Resource<Body, Response>,
                                        session: URLSession = URLSession.shared,
                                        completion: @escaping (Result<Response>) -> Void) {
        performRequest(resource, session: session, completion: completion)
    }

}
