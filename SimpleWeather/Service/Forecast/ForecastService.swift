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
    
    // MARK: - Lifecycle
    
    init(apiRequester: ApiRequester = ApiRequester()) {
        self.apiRequester = apiRequester
    }
    
    // MARK: - Methods
    
    func fetchForecast(latitude: Double,
                       longitude: Double) -> AnyPublisher<ForecastResponse, Error> {
        apiRequester
            .fetch(ForecastEndpoint(), with: (latitude: latitude,
                                              longitude: longitude,
                                              unit: "si"))
    }
    
}
