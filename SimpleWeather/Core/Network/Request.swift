//
//  Request.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

enum RequestError: Error {
    case failedToRequestWithUrl(String)
}

protocol Request {
    var urlRequest: URLRequest { get }
}

extension URLRequest {
    
    mutating func addQueryParameters(parameters: [String: Any]) {
        guard
            !parameters.isEmpty,
            let stringUrl = url?.absoluteString,
            var components = URLComponents(string: stringUrl)
        else { return }

        components.queryItems = components.queryItems ?? []

        for key in parameters.keys.sorted(by: <) {
            let value = "\(parameters[key] ?? "")"
            
            if !value.isEmpty {
                components.queryItems?.append(URLQueryItem(name: key,
                                                           value: value))
            }
        }

        url = components.url
    }

    mutating func addHttpHeadersFields(parameters: [String: String]) {
        for key in parameters.keys.sorted(by: <) {
            setValue(parameters[key],
                     forHTTPHeaderField: key)
        }
    }

    mutating func addBodyParameters(_ parameters: Any) {
        guard
            let data = try? JSONSerialization.data(withJSONObject: parameters,
                                                   options: [])
        else { return }

        httpBody = data
    }
    
}
