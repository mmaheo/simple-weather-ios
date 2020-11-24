//
//  HourlyWeatherComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import SwiftUI

struct HourlyWeatherComponent: View {
    
    // MARK: - Properties
    
    let time: Date
    let temperature: Int
    let iconSystemName: String
    let precipProbability: Int
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            Text(time.format(format: "HH:mm"))
                .accessibility(identifier: "hourly_weather_component_time")
            
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 isLarge: false)
                .accessibility(identifier: "hourly_weather_component_icon")
            
            Text("\(temperature)°")
                .accessibility(identifier: "hourly_weather_component_temperature")
            
            HStack {
                Image(systemName: "drop.fill")
                
                Text("\(precipProbability)%")
                    .accessibility(identifier: "hourly_weather_component_precip_probability")
            }
            .foregroundColor(.blue)
        }
    }
}

#if DEBUG

struct HourlyWeatherComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HourlyWeatherComponent(time: Date(),
                                   temperature: 12,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 3)
            
            HourlyWeatherComponent(time: Date(),
                                   temperature: 12,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 3)
                .preferredColorScheme(.dark)
            
            HourlyWeatherComponent(time: Date(),
                                   temperature: 12,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 3)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

#endif
