//
//  ImageURLs.swift
//  TinyExample
//
//  Created by Joan Disho on 11.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

struct ImageURLs: Decodable {
    let full: String?
    let raw: String?
    let regular: String?
    let small: String?
    let thumb: String?

    enum CodingKeys: String, CodingKey {
        case full
        case raw
        case regular
        case small
        case thumb
    }
}

