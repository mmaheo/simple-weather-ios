//
//  SimpleWeatherApp.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 22/11/2020.
//

import SwiftUI

@main
struct SimpleWeatherApp: App {
    
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ForecastView()
        }
    }
}
