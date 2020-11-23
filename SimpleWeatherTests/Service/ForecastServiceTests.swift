//
//  ForecastServiceTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest
import Combine
@testable import SimpleWeather

class ForecastServiceTests: XCTestCase {

    // MARK: - Properties
    
    private(set) var sut: ForecastService!
    
    private(set) var cancellables: Set<AnyCancellable>!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        sut = ForecastService()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Methods
    
    func testFetchForecast() throws {
        let receivedForecastResponse = expectation(description: "Receive forecast response")
        
        sut
            .fetchForecast(latitude: 0,
                           longitude: 0)
            .sink { (completion) in
                if case let .failure(error) = completion {
                    XCTFail("Error occured while fetching forecast: \(error.localizedDescription)")
                }
            } receiveValue: { (_) in
                receivedForecastResponse.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1,
                            handler: nil)
    }
}
