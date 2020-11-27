//
//  RequestTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

import XCTest
@testable import SimpleWeather

class RequestTests: XCTestCase {

    // MARK: - Properties
    
    private var sut: URLRequest!
    private var url: URL!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        url = URL(string: "https://www.google.com")!
        sut = URLRequest(url: url)
    }

    // MARK: - Methods
    
    func testAddQueryParametersEmpty() throws {
        sut.addQueryParameters(parameters: [:])
        
        XCTAssertEqual(sut.url?.absoluteString, url?.absoluteString)
    }
    
    func testAddQueryParametersMultipleParamsSorted() throws {
        sut.addQueryParameters(parameters: ["b": 2,
                                            "a": 1])
        
        XCTAssertEqual(sut.url!.absoluteString, "\(url!.absoluteString)?a=1&b=2")
    }
    
    func testaddHttpHeadersFieldsEmpty() throws {
        sut.addHttpHeadersFields(parameters: [:])
        
        XCTAssertNil(sut.allHTTPHeaderFields)
    }
    
    func testaddHttpHeadersFieldsMultiple() throws {
        sut.addHttpHeadersFields(parameters: ["b": "2",
                                              "a": "1"])
        
        XCTAssertEqual(sut.allHTTPHeaderFields, ["a": "1",
                                                 "b": "2"])
    }
    
    func testAddBodyParametersEmpty() throws {
        sut.addBodyParameters(["a": "1"])

        XCTAssertEqual(String(decoding: sut.httpBody ?? Data(), as: UTF8.self), "{\"a\":\"1\"}")
    }
        
}
