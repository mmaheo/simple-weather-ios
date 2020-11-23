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
            timeView
            iconView
            temperatureView
            dropView
        }
        .fixedSize(horizontal: true,
                   vertical: false)
    }
}

extension HourlyWeatherComponent {
    
    private var timeView: some View {
        Text(time.format(format: "HH:mm"))
            .font(.body)
            .accessibility(identifier: "hourly_weather_component_time")
    }
    
    private var iconView: some View {
        WeatherIconComponent(iconSystemName: iconSystemName)
            .accessibility(identifier: "hourly_weather_component_icon")
    }
    
    private var temperatureView: some View {
        Text("\(temperature)°")
            .font(.body)
            .accessibility(identifier: "hourly_weather_component_temperature")
    }
    
    private var dropView: some View {
        HStack(spacing: 4) {
            Image(systemName: "drop.fill")
                .font(.body)
                .foregroundColor(.blue)
            
            Text("\(precipProbability)%")
                .font(.body)
                .foregroundColor(.blue)
                .accessibility(identifier: "hourly_weather_component_precip_probability")
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
