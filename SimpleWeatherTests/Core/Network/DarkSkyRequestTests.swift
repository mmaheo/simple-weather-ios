//
//  DarkSkyRequestTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

import XCTest
@testable import SimpleWeather

class DarkSkyRequestTests: XCTestCase {
    
    // MARK: - Properties
    
    private var sut: DarkSkyRequest!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        sut = DarkSkyRequest(apiKey: "api_key",
                             latitude: 1,
                             longitude: 2,
                             language: "en",
                             unit: "si")
    }
    
    // MARK: - Methods
    
    func testInit() throws {
        XCTAssertEqual(sut.urlRequest.url!.absoluteString, "https://api.darksky.net/forecast/api_key/1.0,2.0?exclude=minutely,flags&lang=en&units=si")
    }
    
}
