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
    let temperatureMin: Int
    let temperatureMax: Int
    let iconSystemName: String
    let precipProbability: Int
    
    private var temperatureBarHeight: CGFloat {
        let maxHeight: CGFloat = 100
        let minHeight: CGFloat = 50
        let height = CGFloat(temperature) / CGFloat(temperatureMax) * maxHeight
        
        return min(maxHeight, max(minHeight, height))
    }
    
    private var precipitationBarHeight: CGFloat {
        let maxHeight: CGFloat = 40
        let minHeight: CGFloat = 4
        let height = CGFloat(precipProbability) / 100 * maxHeight
        
        return min(maxHeight, max(minHeight, height))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            temperatureBarView
            precipitationBarView
            timeView
        }
        .frame(width: 60,
               height: 200)
    }
}

extension HourlyWeatherComponent {
    
    private var timeView: some View {
        VStack(spacing: 4) {
            Text("\(time.format(format: "HH"))h")
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            
            Spacer()
        }
    }
    
    private var temperatureBarView: some View {
        VStack(spacing: 4) {
            Spacer()
            
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 size: .normal)
            
            Text("\(temperature)°")
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: temperatureBarHeight)
        }
    }
    
    private var precipitationBarView: some View {
        VStack(spacing: 4) {
            Spacer()
            
            Text("\(precipProbability)%")
                .foregroundColor(Color.blue)
                .minimumScaleFactor(0.3)
                .lineLimit(1)
                .padding(.horizontal, 4)
            
            Rectangle()
                .fill(Color.blue.opacity(0.5))
                .frame(height: precipitationBarHeight)
        }
    }
}

#if DEBUG

struct HourlyWeatherComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HourlyWeatherComponent(time: Date(),
                                   temperature: 100,
                                   temperatureMin: 0,
                                   temperatureMax: 100,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 30)
            
            HourlyWeatherComponent(time: Date(),
                                   temperature: 12,
                                   temperatureMin: 0,
                                   temperatureMax: 30,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 100)
                .preferredColorScheme(.dark)
            
            HourlyWeatherComponent(time: Date(),
                                   temperature: 12,
                                   temperatureMin: 0,
                                   temperatureMax: 30,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 3)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
    }
}

#endif
