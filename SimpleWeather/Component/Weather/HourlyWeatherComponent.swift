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
                .font(.body)
            
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 isLarge: false)
            
            Text("\(temperature)°")
                .font(.body)
            
            HStack(spacing: 4) {
                Image(systemName: "drop.fill")
                    .font(.body)
                    .foregroundColor(.blue)
                
                Text("\(precipProbability)%")
                    .font(.body)
                    .foregroundColor(.blue)
            }
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
        }
    }
}

#endif
