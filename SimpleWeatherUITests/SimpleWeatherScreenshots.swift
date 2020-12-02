//
//  SimpleWeatherScreenshots.swift
//  SimpleWeatherUITests
//
//  Created by Maxime Maheo on 02/12/2020.
//

import XCTest

class SimpleWeatherScreenshots: XCTestCase {

    // MARK: - Properties
    
    private var app: XCUIApplication!
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    // MARK: - Methods
    
    func testTakeScreenshots() throws {
        if UIDevice.current.userInterfaceIdiom == .pad {
            app.navigationBars.buttons.element(boundBy: 0).tap()
            
            snapshot("01Home")
            
            app.navigationBars.buttons.element(boundBy: 0).tap()
            app.tables.buttons.element(boundBy: 1).tap()
            
            snapshot("02Settings")
        } else {
            app.tabBars.buttons.element(boundBy: 0).tap()
            
            snapshot("01Home")
            
            app.tabBars.buttons.element(boundBy: 1).tap()

            snapshot("02Settings")
        }

        app.buttons["units_settings_link"].tap()

        snapshot("03Units")
    }

}
