//
//  BaseRequestTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

import XCTest
@testable import SimpleWeather

class BaseRequestTests: XCTestCase {
    
    // MARK: - Properties
    
    private var sut: BaseRequest!
    private var baseStringUrl: String!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        baseStringUrl = "https://www.google.fr"
        sut = BaseRequest(baseStringUrl: baseStringUrl)
    }
    
    // MARK: - Methods
    
    func testInitWithWrongUrl() throws {
        XCTAssertNil(BaseRequest(baseStringUrl: ""))
    }
    
    func testAddQueryParametersEmpty() throws {
        XCTAssertEqual(sut.addQueryParameters(parameters: [:]).urlRequest.url!.absoluteString, baseStringUrl)
    }
    
    func testAddQueryParametersMultiple() throws {
        XCTAssertEqual(sut.addQueryParameters(parameters: ["b": 2,
                                                           "a": 1]).urlRequest.url!.absoluteString, "\(baseStringUrl!)?a=1&b=2")
    }
    
}
