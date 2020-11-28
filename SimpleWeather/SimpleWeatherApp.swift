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
    
    @StateObject private var forecastStore = ForecastStore()
    
    private let appDependency = AppDependency()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(forecastStore)
        }
    }
}
