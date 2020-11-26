//
//  URLEncoderTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 26/11/2020.
//

import XCTest
@testable import SimpleWeather

class URLEncoderTests: XCTestCase {
        
    // MARK: - Properties
    
    private var request: URLRequest!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        request = URLRequest(url: URL(string: "https://www.google.com")!)
    }
    
    // MARK: - Methods
 
    func testEncodeWithNoParameters() throws {
        let sut = URLEncoder(arrayEncoding: .brackets,
                             boolEncoding: .literal)
        
        XCTAssertEqual(try sut.encode(request: request, parameters: nil).url!.absoluteString, request.url!.absoluteString)
        XCTAssertEqual(try sut.encode(request: request, parameters: [:]).url!.absoluteString, request.url!.absoluteString)
    }
    
    func testEncodeWithBoolLiteralParameters() throws {
        let encoderBoolLiteral = URLEncoder(arrayEncoding: .brackets,
                                            boolEncoding: .literal)
        
        XCTAssertEqual(try encoderBoolLiteral.encode(request: request, parameters: ["first": true]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=true")
        XCTAssertEqual(try encoderBoolLiteral.encode(request: request, parameters: ["first": false]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=false")
    }
    
    func testEncodeWithBoolNumericParameters() throws {
        let encoderBoolLiteral = URLEncoder(arrayEncoding: .brackets,
                                            boolEncoding: .numeric)
        
        XCTAssertEqual(try encoderBoolLiteral.encode(request: request, parameters: ["first": true]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=1")
        XCTAssertEqual(try encoderBoolLiteral.encode(request: request, parameters: ["first": false]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=0")
    }
    
    func testEncodeWithStringParameters() throws {
        let encoderBoolLiteral = URLEncoder(arrayEncoding: .brackets,
                                            boolEncoding: .numeric)
        
        XCTAssertEqual(try encoderBoolLiteral.encode(request: request, parameters: ["first": "test"]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=test")
    }
    
    func testEncodeWithMultipleParameters() throws {
        let encoderBoolLiteral = URLEncoder(arrayEncoding: .brackets,
                                            boolEncoding: .numeric)
        
        XCTAssertEqual(try encoderBoolLiteral.encode(request: request, parameters: ["first": 1,
                                                                                    "second": 2]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=1&second=2")
    }
    
    func testEncodeWithArrayBracketsParameters() throws {
        let encoderArrayBrackets = URLEncoder(arrayEncoding: .brackets,
                                              boolEncoding: .numeric)
        
        XCTAssertEqual(try encoderArrayBrackets.encode(request: request, parameters: ["first": [0]]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first%5B%5D=0")
        XCTAssertEqual(try encoderArrayBrackets.encode(request: request, parameters: ["first": []]).url!.absoluteString,
                       "\(request.url!.absoluteString)?")
    }
    
    func testEncodeWithArrayNoBracketsParameters() throws {
        let encoderArrayNoBrackets = URLEncoder(arrayEncoding: .noBrackets,
                                                boolEncoding: .numeric)
        
        XCTAssertEqual(try encoderArrayNoBrackets.encode(request: request, parameters: ["first": [0]]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first=0")
        XCTAssertEqual(try encoderArrayNoBrackets.encode(request: request, parameters: ["first": []]).url!.absoluteString,
                       "\(request.url!.absoluteString)?")
    }
    
    func testEncodeWithDictionaryParameters() throws {
        let encoderArrayBrackets = URLEncoder(arrayEncoding: .brackets,
                                              boolEncoding: .numeric)
        
        XCTAssertEqual(try encoderArrayBrackets.encode(request: request, parameters: ["first": ["1": 1]]).url!.absoluteString,
                       "\(request.url!.absoluteString)?first%5B1%5D=1")
        XCTAssertEqual(try encoderArrayBrackets.encode(request: request, parameters: ["first": [:]]).url!.absoluteString,
                       "\(request.url!.absoluteString)?")
    }
    
}
