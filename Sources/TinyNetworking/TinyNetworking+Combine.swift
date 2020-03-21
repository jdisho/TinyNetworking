//
//  TinyNetworking+Combine.swift
//  TinyNetworking
//
//  Created by Joan Disho on 04.09.19.
//  Copyright © 2019 Joan Disho. All rights reserved.
//

#if canImport(Combine)

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension TinyNetworking {

    func requestPublisher(
        resource: R,
        session: TinyNetworkingSession = URLSession.shared,
        queue: DispatchQueue = .main
        ) -> AnyPublisher<Response, TinyNetworkingError> {
        let publisher = TinyNetworkingPublisher<Response, TinyNetworkingError> { [weak self] subscriber in
            return self?.request(
                resource: resource,
                session: session,
                queue: queue,
                completion: { result in
                    switch result {
                    case let .success(response):
                        _ = subscriber.receive(response)
                        subscriber.receive(completion: .finished)
                    case let .failure(error):
                        subscriber.receive(completion: .failure(error))
                    }
                }
            )
        }
        return publisher.eraseToAnyPublisher()
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension AnyPublisher where Output == Response, Failure == TinyNetworkingError {

    func map<D: Decodable>(to type: D.Type, decoder: JSONDecoder = .init()) -> AnyPublisher<D, TinyNetworkingError> {
        return compactMap { $0.data }
            .decode(type: type, decoder: decoder)
            .mapError { error -> TinyNetworkingError in
                guard let tinyNetworkingError = error as? TinyNetworkingError else {
                    return .underlying(error, nil)
                }
                return tinyNetworkingError
            }
            .eraseToAnyPublisher()
    }
}


#endif
