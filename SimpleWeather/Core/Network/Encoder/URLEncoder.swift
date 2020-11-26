//
//  URLEncoder.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 26/11/2020.
//

import Foundation

struct URLEncoder {
    
    // MARK: - Properties
    
    private let arrayEncoding: ArrayEncoding
    private let boolEncoding: BoolEncoding
    
    // MARK: - Lifecycle
    
    init(arrayEncoding: ArrayEncoding,
         boolEncoding: BoolEncoding) {
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }
    
    // MARK: - Methods
    
    func encode(request: URLRequest,
                parameters: [String: Any]?) throws -> URLRequest {
        guard
            let parameters = parameters,
            !parameters.isEmpty,
            let url = request.url
        else { return request }

        var urlRequest = request
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = urlComponents.queryItems ?? []
            urlComponents.queryItems?.append(contentsOf: queryItems(parameters: parameters))
            urlRequest.url = urlComponents.url
        }
        
        return urlRequest
    }
    
    // MARK: - Private Methods
    
    private func queryItems(parameters: [String: Any]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        for key in parameters.keys.sorted(by: <) {
            queryItems += queryComponents(key: key,
                                          value: parameters[key])
        }
        
        return queryItems
    }
    
    private func queryComponents(key: String,
                                 value: Any?) -> [URLQueryItem] {
        guard
            let value = value
        else { return [] }
        
        if let dictionary = value as? [String: Any] {
            return dictionary.flatMap {
                queryComponents(key: "\(key)[\($0)]",
                                value: $1)
            }
        } else if let array = value as? [Any] {
            return array.flatMap {
                queryComponents(key: arrayEncoding.encode(key: key),
                                value: $0)
            }
        } else if let bool = value as? Bool {
            return [URLQueryItem(name: key,
                                 value: boolEncoding.encode(value: bool))]
        }

        return [URLQueryItem(name: key,
                             value: "\(value)")]
    }
    
}
