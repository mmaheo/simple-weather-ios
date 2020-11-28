//
//  ForecastResponse.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Foundation

struct ForecastResponse: Decodable {
    let currently: Forecast
    let hourly: DataForecast
    let daily: DataForecast
    
    struct DataForecast: Decodable {
        let data: [Forecast]
    }
}
