//
//  MockSession.swift
//  TinyNetworking
//
//  Created by Alan Steiman on 09/04/2020.
//  Copyright © 2020 Joan Disho. All rights reserved.
//

import Foundation
import TinyNetworking

class MockSession: TinyNetworkingSession {
    
    struct Input {
        let data: Data?
        let httpURLResponse: HTTPURLResponse?
        let error: Swift.Error?
    }
    
    private let input: Input
    
    init(input: Input) {
        self.input = input
    }
    
    func loadData(with urlRequest: URLRequest, queue: DispatchQueue, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        
        DispatchQueue.main.async {
            completionHandler(Response(urlRequest: urlRequest, data: self.input.data, httpURLResponse: self.input.httpURLResponse), self.input.error)
        }
        return URLSessionDataTask()
    }
}
