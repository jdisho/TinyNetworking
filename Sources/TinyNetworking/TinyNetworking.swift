//
//  TinyNetworking.swift
//  TinyNetworking
//
//  Created by Joan Disho on 02.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import Combine

public class TinyNetworking<R: Resource>: TinyNetworkingType {

    public init() {}

    @discardableResult
    public func request(
        resource: R,
        session: TinyNetworkingSession = URLSession.shared,
        queue: DispatchQueue = .main,
        completion: @escaping (Result<Response, TinyNetworkingError>) -> Void
        ) -> URLSessionDataTask {
        let request = URLRequest(resource: resource)
        return session.loadData(with: request, queue: queue) { data, httpURLResponse, error in
            guard error == nil else {
                completion(.failure(.underlying(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            let response = Response(urlRequest: request, data: data)

            guard let httpURLResponse = httpURLResponse as? HTTPURLResponse,
                200..<300 ~= httpURLResponse.statusCode else {
                    completion(.failure(.statusCode(response)))
                    return
            }

            completion(.success(response))
        }
    }
}

