//
//  ApiRequester.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation
import Combine

enum ApiRequesterError: Error {
    case noInternetConnection
    case failedToBuildRequest
    case requestFailed(String?)
    case invalidStatusCode(String?, Int)
    case failedToDecodeResponse
}

final class ApiRequester {
    
    // MARK: - Properties
    
    private let urlSession: URLSession
    private let reachability: Reachability?
    
    // MARK: - Lifecycle
    
    init(urlSession: URLSession = .shared,
         reachability: Reachability? = try? Reachability()) {
       self.urlSession = urlSession
       self.reachability = reachability
   }

    // MARK: - Methods
    func fetch<T: ApiEndpoint>(_ endpoint: T,
                               with parameters: T.RequestDataType) -> AnyPublisher<T.ResponseDataType, Error> {
        if reachability?.connection == Reachability.Connection.unavailable {
            return Fail(error: ApiRequesterError.noInternetConnection)
                .eraseToAnyPublisher()
        }
        
        guard let urlRequest = try? endpoint.buildRequest(parameters: parameters).urlRequest else {
            return Fail(error: ApiRequesterError.failedToBuildRequest)
                .eraseToAnyPublisher()
        }
                
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw ApiRequesterError.requestFailed(urlRequest.url?.absoluteString)
                }
                
                guard 200 ..< 300 ~= urlResponse.statusCode else {
                    throw ApiRequesterError.invalidStatusCode(urlRequest.url?.absoluteString,
                                                              urlResponse.statusCode)
                }
                
                guard let parsedResponse = try? endpoint.parseResponse(data: data) else {
                    throw ApiRequesterError.failedToDecodeResponse
                }
                    
                return parsedResponse
            }
            .retry(max: 2,
                   interval: .seconds(2))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
