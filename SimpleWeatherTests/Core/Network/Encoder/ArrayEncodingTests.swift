//
//  ArrayEncodingTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 26/11/2020.
//

import XCTest
@testable import SimpleWeather

class ArrayEncodingTests: XCTestCase {
        
    // MARK: - Methods
 
    func testEncodeWithBrackets() throws {
        XCTAssertEqual(ArrayEncoding.brackets.encode(key: "key"), "key[]")
        XCTAssertEqual(ArrayEncoding.brackets.encode(key: ""), "[]")
    }
    
    func testEncodeWithNoBrackets() throws {
        XCTAssertEqual(ArrayEncoding.noBrackets.encode(key: "key"), "key")
        XCTAssertEqual(ArrayEncoding.noBrackets.encode(key: ""), "")
    }
    
}
