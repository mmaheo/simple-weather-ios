//
//  ForecastWidgetEntry.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import WidgetKit

struct ForecastWidgetEntry: TimelineEntry {
    
    // MARK: - Properties
    
    let date: Date
    let locality: String?
    let iconSystemName: String?
    let temperature: Int?
    let temperatureMin: Int?
    let temperatureMax: Int?
    let apparentTemperature: Int?
    let hourlyForecast: [Forecast]

    // MARK: - Lifecycle
        
    init(date: Date,
         locality: String? = nil,
         iconSystemName: String? = nil,
         temperature: Int? = nil,
         temperatureMin: Int? = nil,
         temperatureMax: Int? = nil,
         apparentTemperature: Int? = nil,
         hourlyForecast: [Forecast] = []) {
        self.date = date
        self.locality = locality
        self.iconSystemName = iconSystemName
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.apparentTemperature = apparentTemperature
        self.hourlyForecast = hourlyForecast
    }
}
