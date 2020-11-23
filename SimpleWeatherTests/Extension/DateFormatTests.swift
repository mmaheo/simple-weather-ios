//
//  DateFormatTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest
@testable import SimpleWeather

class DateFormatTests: XCTestCase {
    
    // MARK: - Properties
    
    private var sut: Date!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        sut = Date(timeIntervalSince1970: 1605621600)
    }
    
    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Methods
    
    func testFormatWithNoFormat() throws {
        XCTAssertEqual(sut.format(), "Nov 17, 2020")
    }
    
    func testFormatWithSpecifiedFormat() throws {
        XCTAssertEqual(sut.format(format: "HH:mm"), "15:00")
    }
    
}
