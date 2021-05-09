//
//  Forecast.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Foundation
import SwiftUI

struct Forecast: Identifiable, Codable {
    
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
    let sunriseTime: TimeInterval?
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
         sunriseTime: TimeInterval? = nil,
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
        self.sunriseTime = sunriseTime
        self.sunsetTime = sunsetTime
    }
    
    private enum CodingKeys: CodingKey {
        case precipProbability
        case apparentTemperature, temperature, temperatureMin, temperatureMax
        case time, sunriseTime, sunsetTime
        case summary
        case humidity
        case uvIndex
        case windSpeed
        case icon
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
    
    var wrappedTemperatureMin: Int {
        Int(round(temperatureMin ?? 0))
    }
    
    var wrappedTemperatureMax: Int {
        Int(round(temperatureMax ?? 0))
    }
    
    var wrappedTime: Date {
        Date(timeIntervalSince1970: time)
    }
    
    var wrappedSummary: String {
        summary ?? ""
    }
    
    var wrappedHumidity: Int {
        Int(round((humidity ?? 0) * 100))
    }
    
    var wrappedUVIndex: Int {
        uvIndex ?? 0
    }
    
    var wrappedWindSpeed: Int {
        Int(round(windSpeed ?? 0))
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
    
    var wrappedSunriseTime: Date {
        Date(timeIntervalSince1970: sunriseTime ?? 0)
    }

    var wrappedSunsetTime: Date {
        Date(timeIntervalSince1970: sunsetTime ?? 0)
    }
    
    var wrappedTimeOfTheDay: LocalizedStringKey {
        let hours = Int(wrappedTime.format(format: "HH")) ?? 0
        
        if hours >= 7 && hours <= 11 {
            return "this_morning"
        } else if hours >= 12 && hours <= 18 {
            return "this_afternoon"
        } else if hours >= 19 && hours <= 22 {
            return "this_evening"
        }
        
        return "tonight"
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
    static let one = generateForecast()
    
    static let list = Forecast.generateForecasts(number: 15)
    
    // MARK: - Methods
    
    private static func generateForecasts(number: Int) -> [Forecast] {
        (0...number).map { _ in generateForecast() }
    }
    
    private static func generateForecast() -> Forecast {
        Forecast(precipProbability: Float.random(in: 0..<1),
                 apparentTemperature: Float.random(in: 0..<30),
                 temperature: Float.random(in: 0..<30),
                 temperatureMin: Float.random(in: 0..<10),
                 temperatureMax: Float.random(in: 20..<30),
                 time: Double.random(in: 0..<100_000),
                 summary: "A beautiful summary",
                 humidity: Float.random(in: 0..<1),
                 uvIndex: Int.random(in: 0..<10),
                 windSpeed: Float.random(in: 0..<30),
                 icon: nil,
                 sunriseTime: Double.random(in: 0..<100_000),
                 sunsetTime: Double.random(in: 0..<100_000))
    }
}

#endif
