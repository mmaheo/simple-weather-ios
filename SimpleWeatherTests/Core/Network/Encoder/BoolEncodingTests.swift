//
//  BoolEncodingTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 26/11/2020.
//

import XCTest
@testable import SimpleWeather

class BoolEncodingTests: XCTestCase {
        
    // MARK: - Methods
 
    func testEncodeWithLiteral() throws {
        XCTAssertEqual(BoolEncoding.literal.encode(value: true), "true")
        XCTAssertEqual(BoolEncoding.literal.encode(value: false), "false")
    }
    
    func testEncodeWithNumeric() throws {
        XCTAssertEqual(BoolEncoding.numeric.encode(value: true), "1")
        XCTAssertEqual(BoolEncoding.numeric.encode(value: false), "0")
    }
    
}
