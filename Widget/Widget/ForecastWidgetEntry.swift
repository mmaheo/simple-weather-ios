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
    let apparentTemperature: Int?
    let precipProbability: Int?
    let windSpeed: Int?
    let unit: Unit?
    let sunsetTime: Date?
    let hourlyForecast: [Forecast]

    // MARK: - Lifecycle
        
    init(date: Date,
         locality: String? = nil,
         iconSystemName: String? = nil,
         temperature: Int? = nil,
         temperatureMin: Int? = nil,
         apparentTemperature: Int? = nil,
         precipProbability: Int? = nil,
         windSpeed: Int? = nil,
         unit: Unit? = nil,
         sunsetTime: Date? = nil,
         hourlyForecast: [Forecast] = []) {
        self.date = date
        self.locality = locality
        self.iconSystemName = iconSystemName
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.apparentTemperature = apparentTemperature
        self.precipProbability = precipProbability
        self.windSpeed = windSpeed
        self.unit = unit
        self.sunsetTime = sunsetTime
        self.hourlyForecast = hourlyForecast
    }
}
