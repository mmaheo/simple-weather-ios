//
//  BaseRequest.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

class BaseRequest: Request {
    
    // MARK: - Properties
    
    var urlRequest: URLRequest {
        request
    }
    
    private var request: URLRequest
    
    // MARK: - Lifecycle
    
    init?(baseStringUrl: String) {
        guard
            let url = URL(string: baseStringUrl)
        else { return nil }
        
        self.request = URLRequest(url: url)
    }
    
    // MARK: - Methods
    
    func addQueryParameters(parameters: [String: Any]) -> Self {
        request.addQueryParameters(parameters: parameters)
        
        return self
    }
    
}
