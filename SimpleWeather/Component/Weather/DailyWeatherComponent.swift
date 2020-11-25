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
                WeatherIconComponent(iconSystemName: iconSystemName,
                                     isLarge: false)
                
                Text(summary)
                
                Spacer()
            }
            
            LazyVGrid(columns: layout,
                      spacing: 8) {
                makeFieldView(iconSystemName: "thermometer.snowflake",
                              iconColor: .blue,
                              value: "\(temperatureMin)°",
                              title: "§Min")
                makeFieldView(iconSystemName: "thermometer.sun.fill",
                              iconColor: .red,
                              value: "\(temperatureMax)°",
                              title: "§Max")
                makeFieldView(iconSystemName: "drop.fill",
                              iconColor: .blue,
                              value: "\(humidity)%",
                              title: "§Humidity")
                makeFieldView(iconSystemName: "cloud.rain.fill",
                              iconColor: .gray,
                              value: "\(precipProbability)%",
                              title: "§Pricipitation")
                makeFieldView(iconSystemName: "eyeglasses",
                              iconColor: .green,
                              value: "\(uvIndex)",
                              title: "§UV Index")
                makeFieldView(iconSystemName: "wind",
                              iconColor: .blue,
                              value: "\(windSpeed) §mph",
                              title: "§Wind")
                makeFieldView(iconSystemName: "sunrise.fill",
                              iconColor: .yellow,
                              value: sunriseTime.format(format: "HH:mm"),
                              title: "§Sunrise")
                makeFieldView(iconSystemName: "sunset.fill",
                              iconColor: .orange,
                              value: sunsetTime.format(format: "HH:mm"),
                              title: "§Sunset")
            }
        }
    }
}

extension DailyWeatherComponent {
    private func makeFieldView(iconSystemName: String,
                               iconColor: Color,
                               value: String,
                               title: String) -> some View {
        HStack {
            Image(systemName: iconSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24,
                       height: 24)
                .foregroundColor(iconColor)
            
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
