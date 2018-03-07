//
//  RxTinyNetworking.swift
//  RxTinyNetworking
//
//  Created by Joan Disho on 07.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import RxSwift
import TinyNetworking

extension APIProvider: ReactiveCompatible {}

public extension Reactive where Base: APIProvider {

    public func request<Body, Response>(_ resource: Resource<Body, Response>,
                                        session: URLSession = URLSession.shared) -> Single<Response> {

        return Single.create { single in
            let request = URLRequest(resource: resource)
            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    single(.error(error ?? APIError.emptyResult))
                    return
                }
                if let response = response as? HTTPURLResponse {
                    guard 200..<300 ~= response.statusCode else {
                        single(.error(APIError.requestFailed(withStatusCode: response.statusCode)))
                        return
                    }
                }
                guard let result = resource.decode(data) else {
                    single(.error(APIError.decodingFailed))
                    return
                }

                single(.success(result))
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

