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
    case failedStatusCode
    case invalidData
}

typealias PaywallResponse = (PaywallLayout?, Error?) -> Void

final class PaywallService {
    
    // MARK: - Private properties
    
    private var testData: PaywallLayout?
    
    // MARK: - Initializer
    
    init(testData: PaywallLayout? = nil) {
        self.testData = testData
    }
    
    // MARK: - Public API
    
    func fetchPaywall(_ type: PaywallType = .disney, completionHandler: @escaping PaywallResponse) {
        guard testData == nil else {
            completionHandler(testData, nil)
            return
        }

        guard let url = URL(string: "http://localhost:8000/response.json") else {
            completionHandler(nil, NetworkError.invalidURL)
            return
        }

        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.paywall.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                completionHandler(nil, NetworkError.invalidData)
                return
            }
            
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard
                let response = urlResponse as? HTTPURLResponse,
                200 ..< 300 ~= response.statusCode else {
                completionHandler(nil, NetworkError.failedStatusCode)
                return
            }
            
            do {
                let paywall = try JSONDecoder().decode(PaywallLayout.self, from: data)
                completionHandler(paywall, nil)
            } catch {
                print("Failed to parse data. Error = \(error)")
            }
        }
                                                   
        dataTask.resume()
    }
}
