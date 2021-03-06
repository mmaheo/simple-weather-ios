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
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 size: .large)
            
            VStack(alignment: .leading) {
                Text("\(temperature)°")
                    .font(.title)
                    .bold()
                
                Text(String(format: NSLocalizedString("feeling_temperature",
                                                      comment: ""),
                            apparentTemperature))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
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
    }
}

#endif
