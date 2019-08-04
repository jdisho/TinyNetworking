//
//  URLSession+Extentions.swift
//  TinyNetworking
//
//  Created by Joan Disho on 07.04.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public protocol TinyNetworkingSession {
    typealias CompletionHandler = (Data?, URLResponse?, Swift.Error?) -> Void
    func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask

    @available(iOS 13.0, *)
    func loadData(with urlRequest: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: TinyNetworkingSession {
    public func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void
        ) -> URLSessionDataTask {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            queue.async { completionHandler(data, urlResponse, error) }
        }
        task.resume()
        return task
    }

    @available(iOS 13.0, *)
    public func loadData(with urlRequest: URLRequest) -> URLSession.DataTaskPublisher {
        return dataTaskPublisher(for: urlRequest)
    }
}
