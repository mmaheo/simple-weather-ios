//
//  ForecastTests.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 23/11/2020.
//

import XCTest
@testable import SimpleWeather

class ForecastTests: XCTestCase {
    
    // MARK: - Methods
    
    func testWrappedPrecipProbability() throws {
        XCTAssertEqual(Forecast(precipProbability: nil).wrappedPrecipProbability, 0)
        XCTAssertEqual(Forecast(precipProbability: 0).wrappedPrecipProbability, 0)
        XCTAssertEqual(Forecast(precipProbability: 0.4).wrappedPrecipProbability, 40)
        XCTAssertEqual(Forecast(precipProbability: 0.376).wrappedPrecipProbability, 38)
        XCTAssertEqual(Forecast(precipProbability: 0.372).wrappedPrecipProbability, 37)
    }
    
    func testWrappedApparentTemperature() throws {
        XCTAssertEqual(Forecast(apparentTemperature: 10.2).wrappedApparentTemperature, 10)
        XCTAssertEqual(Forecast(apparentTemperature: 10.7).wrappedApparentTemperature, 11)
        
        XCTAssertEqual(Forecast(apparentTemperature: 10, temperature: 12).wrappedApparentTemperature, 10)
        XCTAssertEqual(Forecast(apparentTemperature: nil, temperature: 12).wrappedApparentTemperature, 12)
        XCTAssertEqual(Forecast(apparentTemperature: nil, temperature: nil).wrappedApparentTemperature, 0)
    }
    
    func testWrappedTemperature() throws {
        XCTAssertEqual(Forecast(temperature: 10.2).wrappedTemperature, 10)
        XCTAssertEqual(Forecast(temperature: 10.7).wrappedTemperature, 11)
        
        XCTAssertEqual(Forecast(temperature: 12).wrappedTemperature, 12)
        XCTAssertEqual(Forecast(temperature: nil).wrappedTemperature, 0)
    }
    
    func testWrappedTemperatureMin() throws {
        XCTAssertEqual(Forecast(temperatureMin: 10.2).wrappedTemperatureMin, 10)
        XCTAssertEqual(Forecast(temperatureMin: 10.7).wrappedTemperatureMin, 11)
        
        XCTAssertEqual(Forecast(temperatureMin: 12).wrappedTemperatureMin, 12)
        XCTAssertEqual(Forecast(temperatureMin: nil).wrappedTemperatureMin, 0)
    }
    
    func testWrappedTemperatureMax() throws {
        XCTAssertEqual(Forecast(temperatureMax: 10.2).wrappedTemperatureMax, 10)
        XCTAssertEqual(Forecast(temperatureMax: 10.7).wrappedTemperatureMax, 11)
        
        XCTAssertEqual(Forecast(temperatureMax: 12).wrappedTemperatureMax, 12)
        XCTAssertEqual(Forecast(temperatureMax: nil).wrappedTemperatureMax, 0)
    }
    
    func testWrappedTime() throws {
        XCTAssertEqual(Forecast(time: 12345).wrappedTime, Date(timeIntervalSince1970: 12345))
    }
    
    func testWrappedSummary() throws {
        XCTAssertEqual(Forecast(summary: nil).wrappedSummary, "")
        XCTAssertEqual(Forecast(summary: "summary").wrappedSummary, "summary")
    }
    
    func testWrappedHumidity() throws {
        XCTAssertEqual(Forecast(humidity: nil).wrappedHumidity, 0)
        XCTAssertEqual(Forecast(humidity: 0).wrappedHumidity, 0)
        XCTAssertEqual(Forecast(humidity: 0.4).wrappedHumidity, 40)
        XCTAssertEqual(Forecast(humidity: 0.376).wrappedHumidity, 38)
        XCTAssertEqual(Forecast(humidity: 0.372).wrappedHumidity, 37)
    }
    
    func testWrappedUVIndex() throws {
        XCTAssertEqual(Forecast(uvIndex: nil).wrappedUVIndex, 0)
        XCTAssertEqual(Forecast(uvIndex: 2).wrappedUVIndex, 2)
    }
    
    func testWrappedWindSpeed() throws {
        XCTAssertEqual(Forecast(windSpeed: nil).wrappedWindSpeed, 0)
        XCTAssertEqual(Forecast(windSpeed: 0).wrappedWindSpeed, 0)
        XCTAssertEqual(Forecast(windSpeed: 12.0).wrappedWindSpeed, 12)
        XCTAssertEqual(Forecast(windSpeed: 12.3).wrappedWindSpeed, 12)
        XCTAssertEqual(Forecast(windSpeed: 12.6).wrappedWindSpeed, 13)
    }
    
    func testWrappedIconSystemName() throws {
        XCTAssertEqual(Forecast(icon: "clear-day").wrappedIconSystemName, "sun.max.fill")
        XCTAssertEqual(Forecast(icon: "clear-night").wrappedIconSystemName, "moon.stars.fill")
        XCTAssertEqual(Forecast(icon: "rain").wrappedIconSystemName, "cloud.rain.fill")
        XCTAssertEqual(Forecast(icon: "snow").wrappedIconSystemName, "cloud.snow.fill")
        XCTAssertEqual(Forecast(icon: "sleet").wrappedIconSystemName, "cloud.sleet.fill")
        XCTAssertEqual(Forecast(icon: "wind").wrappedIconSystemName, "wind")
        XCTAssertEqual(Forecast(icon: "fog").wrappedIconSystemName, "cloud.fog.fill")
        XCTAssertEqual(Forecast(icon: "cloudy").wrappedIconSystemName, "cloud.fill")
        XCTAssertEqual(Forecast(icon: "partly-cloudy-day").wrappedIconSystemName, "cloud.sun.fill")
        XCTAssertEqual(Forecast(icon: "partly-cloudy-night").wrappedIconSystemName, "cloud.moon.fill")
        XCTAssertEqual(Forecast(icon: "hail").wrappedIconSystemName, "cloud.hail.fill")
        XCTAssertEqual(Forecast(icon: "thunderstorm").wrappedIconSystemName, "cloud.bolt.fill")
        XCTAssertEqual(Forecast(icon: "tornado").wrappedIconSystemName, "tornado")
        XCTAssertEqual(Forecast(icon: nil).wrappedIconSystemName, "sun.max.fill")
    }
    
    func testWrappedSunriseTime() throws {
        XCTAssertEqual(Forecast(sunriseTime: nil).wrappedSunriseTime, Date(timeIntervalSince1970: 0))
        XCTAssertEqual(Forecast(sunriseTime: 12345).wrappedSunriseTime, Date(timeIntervalSince1970: 12345))
    }
    
    func testWrappedSunsetTime() throws {
        XCTAssertEqual(Forecast(sunsetTime: nil).wrappedSunsetTime, Date(timeIntervalSince1970: 0))
        XCTAssertEqual(Forecast(sunsetTime: 12345).wrappedSunsetTime, Date(timeIntervalSince1970: 12345))
    }
    
    func testWrappedTimeOfTheDay() throws {
        XCTAssertEqual(Forecast(time: 1 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 2h
        XCTAssertEqual(Forecast(time: 2 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 3h
        XCTAssertEqual(Forecast(time: 3 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 4h
        XCTAssertEqual(Forecast(time: 4 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 5h
        XCTAssertEqual(Forecast(time: 5 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 6h
        XCTAssertEqual(Forecast(time: 6 * 60 * 60).wrappedTimeOfTheDay, "§This morning") // 7h
        XCTAssertEqual(Forecast(time: 7 * 60 * 60).wrappedTimeOfTheDay, "§This morning") // 8h
        XCTAssertEqual(Forecast(time: 8 * 60 * 60).wrappedTimeOfTheDay, "§This morning") // 9h
        XCTAssertEqual(Forecast(time: 9 * 60 * 60).wrappedTimeOfTheDay, "§This morning") // 10h
        XCTAssertEqual(Forecast(time: 10 * 60 * 60).wrappedTimeOfTheDay, "§This morning") // 11h
        XCTAssertEqual(Forecast(time: 11 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 12h
        XCTAssertEqual(Forecast(time: 12 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 13h
        XCTAssertEqual(Forecast(time: 13 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 14h
        XCTAssertEqual(Forecast(time: 14 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 15h
        XCTAssertEqual(Forecast(time: 15 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 16h
        XCTAssertEqual(Forecast(time: 16 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 17h
        XCTAssertEqual(Forecast(time: 17 * 60 * 60).wrappedTimeOfTheDay, "§This afternoon") // 18h
        XCTAssertEqual(Forecast(time: 18 * 60 * 60).wrappedTimeOfTheDay, "§This evening") // 19h
        XCTAssertEqual(Forecast(time: 19 * 60 * 60).wrappedTimeOfTheDay, "§This evening") // 20h
        XCTAssertEqual(Forecast(time: 20 * 60 * 60).wrappedTimeOfTheDay, "§This evening") // 21h
        XCTAssertEqual(Forecast(time: 21 * 60 * 60).wrappedTimeOfTheDay, "§This evening") // 22h
        XCTAssertEqual(Forecast(time: 22 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 23h
        XCTAssertEqual(Forecast(time: 23 * 60 * 60).wrappedTimeOfTheDay, "§Tonight") // 24h
    }
    
}
