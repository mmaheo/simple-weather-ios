//
//  ForecastViewTests.swift
//  SimpleWeatherUITests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest

class ForecastViewTests: XCTestCase {
    
    // MARK: - Properties
    
    private var app: XCUIApplication!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }

    // MARK: - Methods
    
    func testExample() throws {
        XCTAssertTrue(app.images["currently_weather_component_icon"].exists)
        XCTAssertTrue(app.staticTexts["currently_weather_component_temperature"].exists)
        XCTAssertTrue(app.staticTexts["currently_weather_component_apparent_temperature"].exists)
        
        XCTAssertTrue(app.staticTexts["hourly_weather_component_time"].exists)
        XCTAssertTrue(app.images["hourly_weather_component_icon"].exists)
        XCTAssertTrue(app.staticTexts["hourly_weather_component_temperature"].exists)
        XCTAssertTrue(app.staticTexts["hourly_weather_component_precip_probability"].exists)
        
        XCTAssertTrue(app.staticTexts["forecast_view_section_title"].exists)
    }
}
