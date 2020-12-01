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
    private let analyticsService: AnalyticsService
    private let ratingService: RatingService
    
    // MARK: - Lifecycle
    
    init() {
        self.userDefaultsService = UserDefaultsService()
        self.forecastService = ForecastService()
        self.locationService = LocationService(userDefaultService: userDefaultsService)
        self.analyticsService = AnalyticsService()
        self.ratingService = RatingService(userDefaultService: userDefaultsService,
                                           analyticsService: analyticsService)
        
        registerDependencies()
    }
    
    // MARK: - Methods
    
    private func registerDependencies() {
        let resolver = Resolver.shared
        
        resolver.register(userDefaultsService)
        resolver.register(forecastService)
        resolver.register(locationService)
        resolver.register(analyticsService)
        resolver.register(ratingService)
    }
}
