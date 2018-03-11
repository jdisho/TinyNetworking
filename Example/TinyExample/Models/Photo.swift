//
//  Photo.swift
//  TinyExample
//
//  Created by Joan Disho on 11.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

struct Photo: Decodable {
    let id: String?
    let urls: ImageURLs?

    enum CodingKeys: String, CodingKey {
        case id
        case urls
    }
}
