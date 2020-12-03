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
    let temperatureMax: Int
    let apparentTemperature: Int
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            headerView
            Spacer()
            currentView
            Spacer()
            temperatureView
        }
        .padding()
    }
}

extension CurrentlyForecastWidgetSmallView {
    
    private var headerView: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            HStack {
                Text(locality)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
            }
            
            Text(date.format(format: "HH:mm"))
                .font(.system(size: 10))
                .foregroundColor(.gray)
        }
    }
    
    private var currentView: some View {
        HStack {
            WeatherIconComponent(iconSystemName: iconSystemName,
                                 size: .small)
            
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
    
    private var temperatureView: some View {
        HStack {
            Spacer()
            MinMaxTemperatureComponent(temperature: temperatureMin,
                                       type: .min)
            
            MinMaxTemperatureComponent(temperature: temperatureMax,
                                       type: .max)
            Spacer()
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
                                         temperatureMax: 12,
                                         apparentTemperature: 8)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

#endif
