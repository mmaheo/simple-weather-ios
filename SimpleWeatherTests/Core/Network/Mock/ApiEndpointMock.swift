//
//  ApiEndpointMock.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

@testable import SimpleWeather
import Foundation

final class ApiEndpointMock: ApiEndpoint {

    typealias RequestDataType = ([String: Any])
    typealias ResponseDataType = (ResponseMock)
    
    // MARK: - Methods
    func buildRequest(parameters: ApiEndpointMock.RequestDataType) throws -> Request {
        let stringUrl = "https://www.google.com"

        guard let request = MockRequest(baseStringUrl: stringUrl, bodyParameters: parameters) else {
            throw RequestError.failedToRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> ApiEndpointMock.ResponseDataType {
        try JSONDecoder()
            .decode(ApiEndpointMock.ResponseDataType.self,
                    from: data)
    }
    
}
