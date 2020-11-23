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
                                 isLarge: true)
            
            VStack(alignment: .leading) {
                Text("\(temperature)°")
                    .font(.title)
                
                Text("§Feeling \(apparentTemperature)°")
                    .font(.callout)
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
        }
    }
}

#endif
