//
//  RequestMock.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

@testable import SimpleWeather
import Foundation

class MockRequest: Request {
    
    // MARK: - Properties
    
    private var request: URLRequest
    private let bodyParameters: Any?

    var urlRequest: URLRequest {
        request
    }
    
    // MARK: - Lifecycle
    
    init?(baseStringUrl: String,
          bodyParameters: Any? = nil) {
        self.bodyParameters = bodyParameters

        guard
            let url = URL(string: baseStringUrl)
        else { return nil }
        
        var request = URLRequest(url: url)
        
        if let bodyParameters = bodyParameters {
            request.addBodyParameters(bodyParameters)
        }
        
        self.request = request
    }
    
}
