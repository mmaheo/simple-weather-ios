//
//  AppInformationTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

import XCTest
@testable import SimpleWeather

class AppInformationTests: XCTestCase {
        
    // MARK: - Properties
    
    private var sut: AppInformation!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        sut = AppInformation(language: "fr",
                             unit: "si",
                             urlEncoder: URLEncoder(arrayEncoding: .brackets,
                                                    boolEncoding: .numeric))
    }
    
    // MARK: - Methods
 
    func testAddQueryParameters() throws {
        var request = URLRequest(url: URL(string: "https://www.google.com")!)

        XCTAssertNoThrow(try sut.addQueryParameters(to: &request))
        
        XCTAssertEqual(request.url!.absoluteString, "https://www.google.com?exclude=minutely,flags&lang=fr&units=si")
    }
    
}
