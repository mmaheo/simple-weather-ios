//
//  ForecastEndpoint.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

final class ForecastEndpoint: ApiEndpoint {
    
    typealias RequestDataType = (latitude: Double,
                                 longitude: Double,
                                 unit: String)
    typealias ResponseDataType = ForecastResponse
    
    // MARK: - Methods
    func buildRequest(parameters: ForecastEndpoint.RequestDataType) throws -> Request {
        guard
            let request = DarkSkyRequest(apiKey: darkSkyApiKey,
                                         latitude: parameters.latitude,
                                         longitude: parameters.longitude,
                                         language: Locale.language(),
                                         unit: parameters.unit)
        else {
            throw RequestError.failedToCreateRequest
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> ForecastEndpoint.ResponseDataType {
        try JSONDecoder()
            .decode(ForecastResponse.self,
                    from: data)
    }
}
