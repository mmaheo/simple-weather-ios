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
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            dayInLettersView
            
            HStack {
                iconView
                summaryView
                
                Spacer()
            }
        }
    }
}

extension DailyWeatherComponent {
    
    private var dayInLettersView: some View {
        Text(time.format(format: "EEEE"))
            .foregroundColor(.secondary)
            .font(.headline)
    }
    
    private var iconView: some View {
        WeatherIconComponent(iconSystemName: iconSystemName,
                             isLarge: false)
    }
    
    private var summaryView: some View {
        Text(summary)
            .font(.headline)
    }
    
}

#if DEBUG

struct DailyWeatherComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DailyWeatherComponent(time: Date(),
                                  iconSystemName: "cloud.rain.fill",
                                  summary: "Mostly cloudy throughout the day.")
            
            DailyWeatherComponent(time: Date(),
                                  iconSystemName: "cloud.rain.fill",
                                  summary: "Mostly cloudy.")
                .preferredColorScheme(.dark)
        }
    }
}

#endif
