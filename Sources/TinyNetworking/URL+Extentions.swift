//
//  URL+Extentions.swift
//  TinyNetworking
//
//  Created by Joan Disho on 13.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

internal extension URL {
    func appendingQueryParameters(_ parameters: [String: Any], encoding: URLEncoding) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.query = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + encoding.query(parameters)

        return urlComponents.url!
    }

}

