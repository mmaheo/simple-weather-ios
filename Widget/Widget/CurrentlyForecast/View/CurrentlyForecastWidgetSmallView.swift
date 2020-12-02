//
//  CurrentlyForecastWidgetSmallView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct CurrentlyForecastWidgetSmallView: View {
    
    // MARK: - Properties
    
    let locality: String
    let date: Date
    let iconSystemName: String
    let temperature: Int
    let temperatureMin: Int
    let apparentTemperature: Int
    let precipProbability: Int
    let windSpeed: Int
    let unit: Unit
    let sunsetTime: Date

    private let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            localityView
            dateView
            Spacer()
            currentView
            Spacer()
            fieldsView
        }
        .padding()
    }
}

extension CurrentlyForecastWidgetSmallView {
    
    private var localityView: some View {
        HStack {
            Text(locality)
                .font(.headline)
                .lineLimit(1)
            
            Spacer()
        }
    }
    
    private var dateView: some View {
        Text(date.format(format: "HH:mm"))
            .font(.system(size: 10))
            .foregroundColor(.gray)
    }
    
    private var currentView: some View {
        HStack {
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 isLarge: false,
                                 isCompact: true)
            
            VStack(alignment: .leading) {
                Text("\(temperature)°")
                    .bold()
                
                Text(String(format: NSLocalizedString("feeling_temperature",
                                                      comment: ""),
                            apparentTemperature))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var fieldsView: some View {
        LazyVGrid(columns: layout,
                  alignment: .leading,
                  spacing: 8) {
            makeFieldView(iconSystemName: "thermometer.snowflake",
                          value: "\(temperatureMin)°")
            makeFieldView(iconSystemName: "cloud.rain.fill",
                          value: "\(precipProbability)%")
            makeFieldView(iconSystemName: "wind",
                          value: "\(windSpeed) \(unit.windSpeedUnit)")
            makeFieldView(iconSystemName: "sunset.fill",
                          value: sunsetTime.format(format: "HH:mm"))
        }
    }
    
}

extension CurrentlyForecastWidgetSmallView {
    private func makeFieldView(iconSystemName: String,
                               value: String) -> some View {
        HStack {
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 isWidget: true)
            
            Text(value)
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

#if DEBUG

struct CurrentlyForecastWidgetSmallView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentlyForecastWidgetSmallView(locality: "Bordeaux",
                                         date: Date(),
                                         iconSystemName: "sun.max.fill",
                                         temperature: 10,
                                         temperatureMin: 0,
                                         apparentTemperature: 8,
                                         precipProbability: 23,
                                         windSpeed: 10,
                                         unit: .si,
                                         sunsetTime: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

#endif
