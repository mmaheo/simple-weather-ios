//
//  StringFirstLetterCapitalized.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 25/11/2020.
//

import XCTest
@testable import SimpleWeather

class StringFirstLetterCapitalized: XCTestCase {
        
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Methods
    
    func testcapitalizingFirstLetter() throws {
        XCTAssertEqual("test".capitalizingFirstLetter(), "Test")
        XCTAssertEqual("".capitalizingFirstLetter(), "")
    }
        
}
