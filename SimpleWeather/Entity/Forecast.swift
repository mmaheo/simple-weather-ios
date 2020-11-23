//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Foundation

struct Forecast {
    let precipProbability: Float?
    let apparentTemperature: Float?
    let temperature: Float?
    let temperatureMin: Float?
    let temperatureMax: Float?
    let time: TimeInterval
    let summary: String?
    let humidity: Float?
    let uvIndex: Int?
    let windSpeed: Float?
    let icon: String?
    let sunriseTime: TimeInterval?
    let sunsetTime: TimeInterval?
}

#if DEBUG

extension Forecast {
    static let one = Forecast(precipProbability: 0.4,
                              apparentTemperature: 15,
                              temperature: 17.09,
                              temperatureMin: nil,
                              temperatureMax: nil,
                              time: 1605621600,
                              summary: "Clear",
                              humidity: 0.6,
                              uvIndex: 5,
                              windSpeed: 2,
                              icon: "partly-cloudy-night",
                              sunriseTime: 1605601600,
                              sunsetTime: 1605641600)
    
    static let list = [
        Forecast(precipProbability: 0.4,
                 apparentTemperature: 15,
                 temperature: 17.09,
                 temperatureMin: nil,
                 temperatureMax: nil,
                 time: 1605621600,
                 summary: "Clear",
                 humidity: 0.6,
                 uvIndex: 5,
                 windSpeed: 2,
                 icon: "clear-day",
                 sunriseTime: 1605601600,
                 sunsetTime: 1605641600),
        Forecast(precipProbability: 0.4,
                 apparentTemperature: 15,
                 temperature: 17.09,
                 temperatureMin: nil,
                 temperatureMax: nil,
                 time: 1605718800,
                 summary: "Clear",
                 humidity: 0.6,
                 uvIndex: 5,
                 windSpeed: 2,
                 icon: "partly-cloudy-night",
                 sunriseTime: 1605601600,
                 sunsetTime: 1605641600)
    ]
}

#endif
