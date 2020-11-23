//
//  CurrentlyWeatherComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import SwiftUI

struct CurrentlyWeatherComponent: View {
    
    // MARK: - Properties
    
    let iconSystemName: String
    let temperature: Int
    let apparentTemperature: Int
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            iconView
            
            VStack(alignment: .leading) {
                temperatureView
                apparentTemperatureView
            }
            
            Spacer()
        }
    }
}

extension CurrentlyWeatherComponent {
    
    private var iconView: some View {
        WeatherIconComponent(iconSystemName: iconSystemName)
            .accessibility(identifier: "currently_weather_component_icon")
    }
    
    private var temperatureView: some View {
        Text("\(temperature)°")
            .font(.title)
            .accessibility(identifier: "currently_weather_component_temperature")
    }
    
    private var apparentTemperatureView: some View {
        Text("§Feeling \(apparentTemperature)°")
            .font(.callout)
            .foregroundColor(.secondary)
            .accessibility(identifier: "currently_weather_component_apparent_temperature")
    }
        
}

#if DEBUG

struct CurrentlyWeatherComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentlyWeatherComponent(iconSystemName: "sun.max.fill",
                                      temperature: 12,
                                      apparentTemperature: 10)
            
            CurrentlyWeatherComponent(iconSystemName: "cloud.rain.fill",
                                      temperature: 17,
                                      apparentTemperature: 17)
                .preferredColorScheme(.dark)
            
            CurrentlyWeatherComponent(iconSystemName: "cloud.rain.fill",
                                      temperature: 17,
                                      apparentTemperature: 17)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

#endif
