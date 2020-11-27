//
//  DarkSkyRequest.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

final class DarkSkyRequest: BaseRequest {
    
    // MARK: - Properties
    
    private let language: String
    private let unit: String
    
    override var urlRequest: URLRequest {
        var request = super.urlRequest
        let parameters = [
            "lang": language,
            "units": unit,
            "exclude": "minutely,flags"
        ]
        
        request.addQueryParameters(parameters: parameters)
        
        return request
    }
    
    // MARK: - Lifecycle
    
    init?(apiKey: String,
          latitude: Double,
          longitude: Double,
          language: String,
          unit: String) {
        self.language = language
        self.unit = unit
        
        super.init(baseStringUrl: "https://api.darksky.net/forecast/\(apiKey)/\(latitude),\(longitude)")
    }
    
}
