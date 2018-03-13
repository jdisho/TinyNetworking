//
//  Photo.swift
//  Papr
//
//  Created by Joan Disho on 03.11.17.
//  Copyright © 2017 Joan Disho. All rights reserved.
//


struct Photo: Decodable {
    let id: String?
    let created: String?
    let updated: String?
    let description: String?
    let color: String?
    let likes: Int?
    let likedByUser: Bool?
    let downloads: Int?
    let views: Int?
    let width: Int?
    let height: Int?
    let user: User?
    let urls: ImageURLs?
    let location: Location?
    let exif: Exif?
    let collectionsItBelongs: [Collection]?
    let links: Links?
    let categories: [Category]?

    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_at"
        case updated = "updated_at"
        case description
        case color
        case likes
        case likedByUser = "liked_by_user"
        case downloads
        case views
        case width
        case height
        case user
        case urls
        case location
        case exif
        case collectionsItBelongs = "current_user_collections"
        case links
        case categories
    }
}


