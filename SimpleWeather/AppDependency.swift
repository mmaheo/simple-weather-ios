//
//  AppDependency.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Injectable

final class AppDependency {
    
    // MARK: - Properties
    
    private let userDefaultsService: UserDefaultsService
    private let forecastService: ForecastService
    private let locationService: LocationService
    
    // MARK: - Lifecycle
    
    init() {
        self.userDefaultsService = UserDefaultsService()
        self.forecastService = ForecastService()
        self.locationService = LocationService(userDefaultService: userDefaultsService)
        
        registerDependencies()
    }
    
    // MARK: - Methods
    
    private func registerDependencies() {
        let resolver = Resolver.shared
        
        resolver.register(userDefaultsService)
        resolver.register(forecastService)
        resolver.register(locationService)
    }
}
