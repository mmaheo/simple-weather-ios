//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Foundation

struct Forecast: Identifiable {
    
    let id = UUID()
    
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
    let sunsetTime: TimeInterval?
    
    init(precipProbability: Float? = nil,
         apparentTemperature: Float? = nil,
         temperature: Float? = nil,
         temperatureMin: Float? = nil,
         temperatureMax: Float? = nil,
         time: TimeInterval = 0,
         summary: String? = nil,
         humidity: Float? = nil,
         uvIndex: Int? = nil,
         windSpeed: Float? = nil,
         icon: String? = nil,
         sunsetTime: TimeInterval? = nil) {
        self.precipProbability = precipProbability
        self.apparentTemperature = apparentTemperature
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.time = time
        self.summary = summary
        self.humidity = humidity
        self.uvIndex = uvIndex
        self.windSpeed = windSpeed
        self.icon = icon
        self.sunsetTime = sunsetTime
    }
}

extension Forecast {
    var wrappedPrecipProbability: Int {
        Int(round((precipProbability ?? 0) * 100))
    }
    
    var wrappedApparentTemperature: Int {
        Int(round(apparentTemperature ?? temperature ?? 0))
    }
    
    var wrappedTemperature: Int {
        Int(round(temperature ?? 0))
    }
    
    var wrappedTime: Date {
        Date(timeIntervalSince1970: time)
    }
    
    var wrappedIconSystemName: String {
        if icon == "clear-day" {
            return "sun.max.fill"
        } else if icon == "clear-night" {
            return "moon.stars.fill"
        } else if icon == "rain" {
            return "cloud.rain.fill"
        } else if icon == "snow" {
            return "cloud.snow.fill"
        } else if icon == "sleet" {
            return "cloud.sleet.fill"
        } else if icon == "wind" {
            return "wind"
        } else if icon == "fog" {
            return "cloud.fog.fill"
        } else if icon == "cloudy" {
            return "cloud.fill"
        } else if icon == "partly-cloudy-day" {
            return "cloud.sun.fill"
        } else if icon == "partly-cloudy-night" {
            return "cloud.moon.fill"
        } else if icon == "hail" {
            return "cloud.hail.fill"
        } else if icon == "thunderstorm" {
            return "cloud.bolt.fill"
        } else if icon == "tornado" {
            return "tornado"
        }
        
        return "sun.max.fill"
    }
    
    var wrappedTimeOfTheDay: String {
        let hours = Int(wrappedTime.format(format: "HH")) ?? 0
        
        if hours >= 7 && hours <= 11 {
            return "§This morning"
        } else if hours >= 12 && hours <= 18 {
            return "§This afternoon"
        } else if hours >= 19 && hours <= 22 {
            return "§This evening"
        }
        
        return "§Tonight"
    }
}

extension Forecast: Equatable {
    static func == (lhs: Forecast,
                    rhs: Forecast) -> Bool {
        lhs.id == rhs.id
    }
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
                 sunsetTime: 1605641600)
    ]
}

#endif
