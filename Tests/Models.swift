//
//  Models.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 09/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import Foundation

struct FooEncodable: Codable, Equatable {
    let params: [String: String]
}

struct BarEncodable: Codable, Equatable {
    let foo: Bool
}

extension Encodable {
    var data: Data {
        return try! JSONEncoder().encode(self)
    }
}
