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
    private(set) var isWidget: Bool = false
    
    private var precipIconWidth: CGFloat {
        isWidget ? 10 : 14
    }
    
    private var barHeightRatio: CGFloat {
        isWidget ? 4 : 2
    }
    
    private var temperatureBarHeight: CGFloat {
        let temperaturePercentage = CGFloat(temperature) / CGFloat(temperatureMax)
        let maxHeight: CGFloat = componentHeight / barHeightRatio
        let height = temperaturePercentage * maxHeight
        
        return min(maxHeight, max(minBarHeight, height))
    }
    
    private var precipitationBarHeight: CGFloat {
        let height = CGFloat(precipProbability) / 100 * temperatureBarHeight
        
        return min(temperatureBarHeight, max(minBarHeight, height))
    }
    
    private var componentHeight: CGFloat {
        isWidget ? 110 : 200
    }
    
    private var minBarHeight: CGFloat {
        isWidget ? 30 : 40
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            temperatureBarView
            
            if precipProbability != 0 {
                precipitationBarView
            }
            
            timeAndIconView
        }
        .frame(height: componentHeight)
    }
}

extension HourlyWeatherComponent {
    
    private var timeAndIconView: some View {
        VStack(spacing: 4) {
            Text("\(time.format(format: "HH"))h")
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 isCompact: true,
                                 isWidget: isWidget)
            
            Spacer()
        }
    }
    
    private var temperatureBarView: some View {
        VStack(spacing: 4) {
            Spacer()
            
            Text("\(temperature)°")
                .lineLimit(1)
                .minimumScaleFactor(0.3)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.yellow)
                .frame(width: 40,
                       height: temperatureBarHeight)
        }
    }
    
    private var precipitationBarView: some View {
        VStack(spacing: 4) {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue)
                    
                Text("\(precipProbability)%")
                    .foregroundColor(Color.white.opacity(0.8))
                    .minimumScaleFactor(0.3)
                    .lineLimit(1)
                    .padding(.horizontal, 4)
            }
            .frame(width: 40,
                   height: precipitationBarHeight)
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
                                   precipProbability: 1)
            
            HourlyWeatherComponent(time: Date(),
                                   temperature: 100,
                                   temperatureMin: 0,
                                   temperatureMax: 100,
                                   iconSystemName: "cloud.rain.fill",
                                   precipProbability: 1,
                                   isWidget: true)
            
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
