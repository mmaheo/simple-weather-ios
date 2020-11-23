//
//  LocaleLanguageTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest
@testable import SimpleWeather

class LocaleLanguageTests: XCTestCase {
        
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Methods
    
    func testPreferredLocaleWithPreferredLanguages() throws {
        XCTAssertEqual(Locale.preferredLocale(preferredLanguages: ["en"]).identifier, Locale(identifier: "en").identifier)
    }
    
    func testPreferredLocaleWithNoPreferredLanguages() throws {
         XCTAssertEqual(Locale.preferredLocale(preferredLanguages: []), Locale.current)
    }
        
}
