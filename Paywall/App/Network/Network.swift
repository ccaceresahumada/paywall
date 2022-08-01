//
//  Network.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation

enum PaywallType: String {
    case disney
    case espn
}

enum NetworkError: Error {
    case invalidURL
}

class Network {
    
    func fetchPaywall(_ type: PaywallType = .disney, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void ) {
        guard let url = URL(string: "http://localhost:8000/response.json") else {
            completionHandler(nil, nil, NetworkError.invalidURL)
            return
        }
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.paywall.dataTask(with: urlRequest, completionHandler: completionHandler)
        dataTask.resume()
    }
}
