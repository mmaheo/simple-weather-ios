//
//  SimpleWeatherApp.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 22/11/2020.
//

import SwiftUI
import WidgetKit
import Bugsnag
import Purchases

@main
struct SimpleWeatherApp: App {
    
    // MARK: - Properties
    
    @StateObject private var forecastStore = ForecastStore()
    @StateObject private var locationStore = LocationStore()
    @StateObject private var settingsStore = SettingsStore()
    @StateObject private var ratingStore = RatingStore()
    @StateObject private var paywallStore = PaywallStore()
    
    private let appDependency = AppDependency()
    
    // MARK: - Lifecycle
    
    init() {
        Bugsnag.start()
        
        #if DEBUG
        Purchases.debugLogsEnabled = true
        #else
        Purchases.debugLogsEnabled = false
        #endif
        
        Purchases.configure(withAPIKey: "tSHMrafnMxiuwEtIyRCGPgbnvthbAdoy")
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear { WidgetCenter.shared.reloadAllTimelines() }
                .environmentObject(forecastStore)
                .environmentObject(locationStore)
                .environmentObject(settingsStore)
                .environmentObject(ratingStore)
                .environmentObject(paywallStore)
        }
    }
}
