//
//  ApiRequesterTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

import XCTest
@testable import SimpleWeather
import Combine

class ApiRequesterTests: XCTestCase {
    
    // MARK: - Properties
    
    private var sut: ApiRequester!
    
    private var cancellables: Set<AnyCancellable>!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
                
        sut = ApiRequester(urlSession: urlSession)
        cancellables = Set<AnyCancellable>()
    }
    
    // MARK: - Methods
    
    func testFetch() throws {
        let mockResponse =
        """
        {
            "data": [
                "hello", "world"
            ]
        }
        """
        let mockJSONData = mockResponse.data(using: .utf8)!
        URLProtocolMock.requestHandler = { request in
            (HTTPURLResponse(), mockJSONData)
        }
        
        let receivedResponse = expectation(description: "Receive response")
        
        sut
            .fetch(ApiEndpointMock(), with: [:])
            .sink { (completion) in
                if case let .failure(error) = completion {
                    XCTFail("Error occured while fetching forecast: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                XCTAssertFalse(response.values.isEmpty)
                XCTAssertEqual(response.values[0], "hello")
                XCTAssertEqual(response.values[1], "world")

                receivedResponse.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1,
                            handler: nil)

    }
    
    func testFetchWithWrongStatusCode() {
        let urlResponse = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                          statusCode: 400,
                                          httpVersion: nil,
                                          headerFields: nil)
        URLProtocolMock.requestHandler = { request in
            (urlResponse!, Data())
        }
        
        let receivedResponse = expectation(description: "Receive response")
        
        sut
            .fetch(ApiEndpointMock(), with: [:])
            .sink { (completion) in
                if case .failure = completion {
                    receivedResponse.fulfill()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10,
                            handler: nil)
    }
    
    func testFetchWithWrongData() {
        let mockResponse =
        """
        wrong data
        """
        let mockJSONData = mockResponse.data(using: .utf8)!
        URLProtocolMock.requestHandler = { request in
            (HTTPURLResponse(), mockJSONData)
        }
        
        let receivedResponse = expectation(description: "Receive response")
        
        sut
            .fetch(ApiEndpointMock(), with: [:])
            .sink { (completion) in
                if case .failure = completion {
                    receivedResponse.fulfill()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10,
                            handler: nil)
    }
    
    func testFetchWithCellularConnection() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
        
        sut = ApiRequester(urlSession: urlSession,
                           reachability: ReachabilityMock(connection: .cellular))
        
        let mockResponse =
        """
        {
            "data": [
                "hello", "world"
            ]
        }
        """
        let mockJSONData = mockResponse.data(using: .utf8)!
        URLProtocolMock.requestHandler = { request in
            (HTTPURLResponse(), mockJSONData)
        }
        
        let receivedResponse = expectation(description: "Receive response")
        
        sut
            .fetch(ApiEndpointMock(), with: [:])
            .sink { _ in

            } receiveValue: { _ in
                receivedResponse.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1,
                            handler: nil)
    }
    
    func testFetchWithWifiConnection() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
        
        sut = ApiRequester(urlSession: urlSession,
                           reachability: ReachabilityMock(connection: .wifi))
        
        let mockResponse =
        """
        {
            "data": [
                "hello", "world"
            ]
        }
        """
        let mockJSONData = mockResponse.data(using: .utf8)!
        URLProtocolMock.requestHandler = { request in
            (HTTPURLResponse(), mockJSONData)
        }
        
        let receivedResponse = expectation(description: "Receive response")
        
        sut
            .fetch(ApiEndpointMock(), with: [:])
            .sink { _ in

            } receiveValue: { _ in
                receivedResponse.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1,
                            handler: nil)
    }
    
    func testFetchWithUnavailableConnection() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
        
        sut = ApiRequester(urlSession: urlSession,
                           reachability: ReachabilityMock(connection: .unavailable))
        
        let mockResponse =
        """
        {
            "data": [
                "hello", "world"
            ]
        }
        """
        let mockJSONData = mockResponse.data(using: .utf8)!
        URLProtocolMock.requestHandler = { request in
            (HTTPURLResponse(), mockJSONData)
        }
        
        let receivedResponse = expectation(description: "Receive response")
        
        sut
            .fetch(ApiEndpointMock(), with: [:])
            .sink { (completion) in
                if case .failure = completion {
                    receivedResponse.fulfill()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10,
                            handler: nil)
    }
    
}
