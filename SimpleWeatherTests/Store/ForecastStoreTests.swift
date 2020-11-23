//
//  ForecastStoreTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest
import Combine
@testable import SimpleWeather

class ForecastStoreTests: XCTestCase {
    
    // MARK: - Properties
    
    private(set) var sut: ForecastStore!
    
    private(set) var cancellables: Set<AnyCancellable>!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        sut = ForecastStore()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Methods
    
    func testInitWithNoValues() throws {
        XCTAssertNil(sut.currently)
        XCTAssertTrue(sut.hourly.isEmpty)
        XCTAssertTrue(sut.daily.isEmpty)
    }
    
    func testInitWithValues() throws {
        let sut = ForecastStore(currently: Forecast.one,
                                hourly: Forecast.list,
                                daily: Forecast.list)
        
        XCTAssertNotNil(sut.currently)
        XCTAssertFalse(sut.hourly.isEmpty)
        XCTAssertFalse(sut.daily.isEmpty)
    }
    
    func testFetchForecastAction() {
        let receivedCurrentlyForecastResponse = expectation(description: "Receive currently forecast response")
        let receivedHourlyForecastResponse = expectation(description: "Receive hourly forecast response")
        let receivedDailyForecastResponse = expectation(description: "Receive daily forecast response")
        
        sut.dispatch(action: .fetchForecast)
        
        sut.$currently
            .sink {
                if $0 != nil {
                    receivedCurrentlyForecastResponse.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.$hourly
            .sink {
                if !$0.isEmpty {
                    receivedHourlyForecastResponse.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.$daily
            .sink {
                if !$0.isEmpty {
                    receivedDailyForecastResponse.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1,
                            handler: nil)
    }
    
}
