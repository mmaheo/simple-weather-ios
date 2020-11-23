//
//  ForecastService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Injectable
import Combine

final class ForecastService: Injectable {
    
    typealias FetchForecastResponseType = (currently: Forecast,
                                           hourly: [Forecast],
                                           daily: [Forecast])
    
    // MARK: - Methods
    
    func fetchForecast(latitude: Double,
                       longitude: Double) -> Deferred<Future<FetchForecastResponseType, Error>> {
        Deferred {
            Future { promise in
                promise(.success(FetchForecastResponseType(currently: Forecast.one,
                                                           hourly: Forecast.list,
                                                           daily: Forecast.list)))
            }
        }
    }
    
}
