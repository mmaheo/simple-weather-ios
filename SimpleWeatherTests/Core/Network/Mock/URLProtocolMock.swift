//
//  URLProtocolMock.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    
    // MARK: - Properties
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    // MARK: - Methods
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            return assertionFailure("Received unexpected request with no handler set")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
    
}
