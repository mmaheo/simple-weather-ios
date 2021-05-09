//
//  ForecastService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Injectable
import Combine

final class ForecastService: Injectable {
    
    // MARK: - Properties
    
    private var apiRequester: ApiRequester
    private weak var userDefaultService: UserDefaultsService?

    // MARK: - Lifecycle
    
    init(apiRequester: ApiRequester = ApiRequester(),
         userDefaultService: UserDefaultsService) {
        self.apiRequester = apiRequester
        self.userDefaultService = userDefaultService
    }
    
    // MARK: - Methods
    
    func fetchForecast(latitude: Double,
                       longitude: Double,
                       unit: Unit) -> AnyPublisher<ForecastResponse, Error> {
        userDefaultService?.incrementNetworkCalls()
        
        return apiRequester
            .fetch(ForecastEndpoint(), with: (latitude: latitude,
                                              longitude: longitude,
                                              unit: unit.rawValue))
    }
    
}
