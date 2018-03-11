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

    private let apiProvider = APIProvider()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPhotos(from: URL(string: "https://api.unsplash.com/photos")!)
    }

    private func fetchPhotos(from url: URL) {
        let photoResource = SimpleResource<[Photo]>(url: url)

        apiProvider.request(photoResource) { result in
            switch result {
            case let .success(photos):
                print(photos)
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }
}

