//
//  ViewController.swift
//  TinyExample
//
//  Created by Joan Disho on 11.03.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import UIKit
import TinyNetworking

class ViewController: UIViewController {

    private let unsplash = Unsplash()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos(page: "1", perPage: "10")
    }

    private func fetchPhotos(page: String, perPage: String) {
        var params: [String: String] = [:]
        params["page"] = page
        params["per_page"] = perPage
        params["order_by"] = OrderBy.popular.value

        let photos = SimpleResource<[Photo]>(url: UnsplashAPI.photos(page: Int(page),
                                                                        perPage: Int(perPage),
                                                                        orderBy: .popular).path,
                                             parameters: params)


        unsplash.request(photos) { result in
            switch result {
            case let .success(photos):
                print(photos)
            case let .error(error):
                print(error)
            }
        }
    }
}

