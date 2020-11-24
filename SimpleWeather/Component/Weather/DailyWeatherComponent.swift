//
//  DailyWeatherComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import SwiftUI

struct DailyWeatherComponent: View {
    
    // MARK: - Properties
    
    let time: Date
    let iconSystemName: String
    let summary: String
    let temperatureMin: Int
    let temperatureMax: Int
    let humidity: Int
    let precipProbability: Int
    let uvIndex: Int
    let windSpeed: Int
    let sunriseTime: Date
    let sunsetTime: Date
    
    // MARK: - Body
    
    var body: some View {
        Text("todo")
    }
}

#if DEBUG

struct DailyWeatherComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DailyWeatherComponent(time: Date(),
                                  iconSystemName: "cloud.rain.fill",
                                  summary: "Mostly cloudy throughout the day.",
                                  temperatureMin: 0,
                                  temperatureMax: 20,
                                  humidity: 40,
                                  precipProbability: 32,
                                  uvIndex: 4,
                                  windSpeed: 12,
                                  sunriseTime: Date(),
                                  sunsetTime: Date())
            
            DailyWeatherComponent(time: Date(),
                                  iconSystemName: "cloud.rain.fill",
                                  summary: "Mostly cloudy.",
                                  temperatureMin: 1,
                                  temperatureMax: 23,
                                  humidity: 23,
                                  precipProbability: 67,
                                  uvIndex: 7,
                                  windSpeed: 42,
                                  sunriseTime: Date(),
                                  sunsetTime: Date())
                .preferredColorScheme(.dark)
            
            DailyWeatherComponent(time: Date(),
                                  iconSystemName: "cloud.rain.fill",
                                  summary: "Mostly cloudy.",
                                  temperatureMin: 4,
                                  temperatureMax: 25,
                                  humidity: 86,
                                  precipProbability: 87,
                                  uvIndex: 1,
                                  windSpeed: 23,
                                  sunriseTime: Date(),
                                  sunsetTime: Date())
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

#endif
