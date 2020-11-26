//
//  AppInformation.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 26/11/2020.
//

import Foundation

struct AppInformation: RequestBehavior {
    
    // MARK: - Properties
    
    private let language: String
    private let unit: String
    private let urlEncoder: URLEncoder
    
    // MARK: - Lifecycle
    
    init(language: String,
         unit: String,
         urlEncoder: URLEncoder) {
        self.language = language
        self.unit = unit
        self.urlEncoder = urlEncoder
    }
    
    // MARK: - Methods
    
    func addQueryParameters(to request: inout URLRequest) throws {
        request = try urlEncoder.encode(request: request,
                                        parameters: ["lang": language,
                                                     "units": unit,
                                                     "exclude": "minutely,flags"])
    }
    
}
