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
    private(set) var isWidget: Bool = false
    
    private var spacing: CGFloat {
        isWidget ? 8 : 16
    }
    
    private var precipIconWidth: CGFloat {
        isWidget ? 14 : 20
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: spacing) {
            timeView
            iconView
            temperatureView
            precipitationView
        }
    }
}

extension HourlyWeatherComponent {
    
    private var timeView: some View {
        Text(time.format(format: "HH:mm"))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    private var iconView: some View {
        WeatherIconComponent(iconSystemName: iconSystemName,
                             isCompact: true,
                             isWidget: isWidget)
    }
    
    private var temperatureView: some View {
        Text("\(temperature)°")
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    private var precipitationView: some View {
        HStack(spacing: 4) {
            Image(systemName: "cloud.rain.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: precipIconWidth,
                       height: precipIconWidth)
            
            Text("\(precipProbability)%")
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .foregroundColor(.blue)
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
