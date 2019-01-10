//
//  Task.swift
//  TinyNetworking
//
//  Created by Joan Disho on 31.03.18.
//

import Foundation

public enum Task {
    case requestWithParameters([String: Any], encoding: URLEncoding)
    case requestWithEncodable(Encodable)
}
