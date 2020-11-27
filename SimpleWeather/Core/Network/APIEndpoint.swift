//
//  APIEndpoint.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

protocol RequestBuilder {
    
    associatedtype RequestDataType

    // MARK: - Methods
    
    func buildRequest(parameters: RequestDataType) throws -> Request
}

protocol ResponseParser {
    
    associatedtype ResponseDataType
    
    // MARK: - Methods
    
    func parseResponse(data: Data) throws -> ResponseDataType
}

typealias ApiEndpoint = RequestBuilder & ResponseParser
