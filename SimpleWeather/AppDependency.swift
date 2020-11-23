//
//  AppDependency.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Injectable

final class AppDependency {
    
    // MARK: - Properties
    
    private let forecastService: ForecastService
    
    // MARK: - Lifecycle
    
    init() {
        self.forecastService = ForecastService()
        
        registerDependencies()
    }
    
    // MARK: - Methods
    
    private func registerDependencies() {
        let resolver = Resolver.shared
        
        resolver.register(forecastService)
    }
}
