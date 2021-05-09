//
//  SimpleWeatherApp.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 22/11/2020.
//

import SwiftUI
import WidgetKit

@main
struct SimpleWeatherApp: App {
    
    // MARK: - Properties
    
    @StateObject private var forecastStore = ForecastStore()
    @StateObject private var locationStore = LocationStore()
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var ratingStore = RatingStore()
    
    private let appDependency = AppDependency()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear { WidgetCenter.shared.reloadAllTimelines() }
                .environmentObject(forecastStore)
                .environmentObject(locationStore)
                .environmentObject(settingsStore)
                .environmentObject(ratingStore)
        }
    }
}
