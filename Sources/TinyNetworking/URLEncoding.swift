//
//  URLEncoding.swift
//  TinyNetworking
//
//  Created by Joan Disho on 22.11.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import Foundation

public struct URLEncoding {

    public enum ArrayEncoding {
        case brackets
        case noBrackets

        public func encode(key: String) -> String {
            switch self {
            case .brackets:
                return "\(key)[]"
            case .noBrackets:
                return key
            }
        }
    }

    public let arrayEncoding: ArrayEncoding

    public init(arrayEncoding: ArrayEncoding) {
        self.arrayEncoding = arrayEncoding
    }

    public func query(_ parameters: [String: Any]) -> String {
        var components = [(String, String)]()

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }

        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components = [(String, String)]()

        if let dictionary = value as? [String: Any] {
            for (innerKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(innerKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
            }
        } else {
            components.append((key, "\(value)"))
        }

        return components
    }
}
