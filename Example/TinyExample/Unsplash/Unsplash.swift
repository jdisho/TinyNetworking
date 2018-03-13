//
//  UnsplashManager.swift
//  TinyExample
//
//  Created by Joan Disho on 13.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation
import TinyNetworking
import RxSwift

struct Unsplash {

    private let apiProvider: APIProvider

    init(apiProvider: APIProvider = APIProvider()) {
        self.apiProvider = apiProvider
    }

    public func request<Body, Response>(_ resource: Resource<Body, Response>,
                                        withToken token: String? = nil) -> Single<Response> {

        guard let token = token else {
            let resource = resource.addHeader(key: "Authorization",
                                              value: "Client-ID " + UnsplashSettings.clientID.string)

            return apiProvider.rx.request(resource)
                .observeOn(MainScheduler.instance)
        }

        let authorizedResource = resource.addHeader(key: "Authorization",
                                                    value: "Bearer" + token)

        return apiProvider.rx.request(authorizedResource)
            .observeOn(MainScheduler.instance)
    }

    public func request<Body, Response>(_ resource: Resource<Body, Response>,
                                        withToken token: String? = nil,
                                        completion: @escaping (Result<Response>) -> Void) {

        guard let token = token else {
            let resource = resource.addHeader(key: "Authorization",
                                              value: "Client-ID " + UnsplashSettings.clientID.string)

            apiProvider.request(resource, completion: completion)
            return
        }

        let authorizedResource = resource.addHeader(key: "Authorization",
                                                    value: "Bearer" + token)

        apiProvider.request(authorizedResource, completion: completion)
        return
    }
}
