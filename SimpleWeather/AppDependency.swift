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
    private let ratingService: RatingService
    private let purchaseService: PurchaseService
    
    // MARK: - Lifecycle
    
    init() {
        self.userDefaultsService = UserDefaultsService()
        self.forecastService = ForecastService()
        self.locationService = LocationService(userDefaultService: userDefaultsService)
        self.ratingService = RatingService(userDefaultService: userDefaultsService)
        self.purchaseService = PurchaseService()
        
        registerDependencies()
        
        userDefaultsService.incrementSessions()
    }
    
    // MARK: - Methods
    
    private func registerDependencies() {
        let resolver = Resolver.shared
        
        resolver.register(userDefaultsService)
        resolver.register(forecastService)
        resolver.register(locationService)
        resolver.register(ratingService)
        resolver.register(purchaseService)
    }
}
