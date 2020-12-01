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
    let unit: Unit
    let sunriseTime: Date
    let sunsetTime: Date
    
    private let layout = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 16) {
            Text(time.format(format: "EEEE").capitalizingFirstLetter())
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack {
                WeatherIconComponent(iconSystemName: iconSystemName)
                
                Text(summary)
                    .font(.subheadline)
                
                Spacer()
            }
            
            LazyVGrid(columns: layout,
                      spacing: 8) {
                makeFieldView(iconSystemName: "thermometer.snowflake",
                              value: "\(temperatureMin)°",
                              title: "min")
                makeFieldView(iconSystemName: "thermometer.sun.fill",
                              value: "\(temperatureMax)°",
                              title: "max")
                makeFieldView(iconSystemName: "cloud.rain.fill",
                              value: "\(precipProbability)%",
                              title: "precipitation")
                makeFieldView(iconSystemName: "wind",
                              value: "\(windSpeed) \(unit.windSpeedUnit)",
                              title: "wind")
                makeFieldView(iconSystemName: "sunrise.fill",
                              value: sunriseTime.format(format: "HH:mm"),
                              title: "sunrise")
                makeFieldView(iconSystemName: "sunset.fill",
                              value: sunsetTime.format(format: "HH:mm"),
                              title: "sunset")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

extension DailyWeatherComponent {
    private func makeFieldView(iconSystemName: String,
                               value: String,
                               title: LocalizedStringKey) -> some View {
        HStack {
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 isCompact: true)
            
            VStack(alignment: .leading) {
                Text(value)
                    .font(.subheadline)
                    .bold()
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
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
                                  unit: .si,
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
                                  unit: .si,
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
                                  unit: .si,
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
