//
//  ResponseMock.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

final class ResponseMock: Decodable {
    let values: [String]
    
    enum CodingKeys: String, CodingKey {
        case values = "data"
    }
}
