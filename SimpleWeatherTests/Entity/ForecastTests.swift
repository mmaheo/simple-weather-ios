//
//  ForecastTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest
@testable import SimpleWeather

class ForecastTests: XCTestCase {
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Methods
    
    func testWrappedApparentTemperature() throws {
        XCTAssertEqual(Forecast(apparentTemperature: 10.2).wrappedApparentTemperature, 10)
        XCTAssertEqual(Forecast(apparentTemperature: 10.7).wrappedApparentTemperature, 11)
        
        XCTAssertEqual(Forecast(apparentTemperature: 10, temperature: 12).wrappedApparentTemperature, 10)
        XCTAssertEqual(Forecast(apparentTemperature: nil, temperature: 12).wrappedApparentTemperature, 12)
        XCTAssertEqual(Forecast(apparentTemperature: nil, temperature: nil).wrappedApparentTemperature, 0)
    }
    
    func testWrappedTemperature() throws {
        XCTAssertEqual(Forecast(temperature: 10.2).wrappedTemperature, 10)
        XCTAssertEqual(Forecast(temperature: 10.7).wrappedTemperature, 11)
        
        XCTAssertEqual(Forecast(temperature: 12).wrappedTemperature, 12)
        XCTAssertEqual(Forecast(temperature: nil).wrappedTemperature, 0)
    }
    
    func testWrappedIconSystemName() throws {
        XCTAssertEqual(Forecast(icon: "clear-day").wrappedIconSystemName, "sun.max.fill")
        XCTAssertEqual(Forecast(icon: "clear-night").wrappedIconSystemName, "moon.stars.fill")
        XCTAssertEqual(Forecast(icon: "rain").wrappedIconSystemName, "cloud.rain.fill")
        XCTAssertEqual(Forecast(icon: "snow").wrappedIconSystemName, "cloud.snow.fill")
        XCTAssertEqual(Forecast(icon: "sleet").wrappedIconSystemName, "cloud.sleet.fill")
        XCTAssertEqual(Forecast(icon: "wind").wrappedIconSystemName, "wind")
        XCTAssertEqual(Forecast(icon: "fog").wrappedIconSystemName, "cloud.fog.fill")
        XCTAssertEqual(Forecast(icon: "cloudy").wrappedIconSystemName, "cloud.fill")
        XCTAssertEqual(Forecast(icon: "partly-cloudy-day").wrappedIconSystemName, "cloud.sun.fill")
        XCTAssertEqual(Forecast(icon: "partly-cloudy-night").wrappedIconSystemName, "cloud.moon.fill")
        XCTAssertEqual(Forecast(icon: "hail").wrappedIconSystemName, "cloud.hail.fill")
        XCTAssertEqual(Forecast(icon: "thunderstorm").wrappedIconSystemName, "cloud.bolt.fill")
        XCTAssertEqual(Forecast(icon: "tornado").wrappedIconSystemName, "tornado")
        XCTAssertEqual(Forecast(icon: nil).wrappedIconSystemName, "sun.max.fill")
    }
    
}
