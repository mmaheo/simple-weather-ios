//
//  HourlyForecastWidgetMediumView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct HourlyForecastWidgetMediumView: View {
    
    // MARK: - Properties
    
    let locality: String
    let date: Date
    let temperatureMin: Int
    let temperatureMax: Int
    let hourlyForecasts: [Forecast]
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            Spacer()
            forecastView
        }
        .padding()
    }
}

extension HourlyForecastWidgetMediumView {
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Text(locality)
                .font(.headline)
                .lineLimit(1)
            
            MinMaxTemperatureComponent(temperature: temperatureMin,
                                       type: .min)
            
            MinMaxTemperatureComponent(temperature: temperatureMax,
                                       type: .max)
            
            Spacer()
            
            Text(date.format(format: "HH:mm"))
                .font(.system(size: 10))
                .foregroundColor(.gray)
        }
    }
    
    private var forecastView: some View {
        HStack(spacing: 0) {
            ForEach(hourlyForecasts) { forecast in
                let isLastItem = hourlyForecasts.last == forecast
                
                VStack {
                    Text("\(forecast.wrappedTime.format(format: "HH"))h")
                        .font(.caption)
                    
                    Spacer()
                    
                    WeatherIconComponent(iconSystemName: forecast.wrappedIconSystemName,
                                         size: .small)
                    
                    Spacer()
                    
                    Text("\(forecast.wrappedTemperature)°")
                        .font(.caption)
                        .bold()
                }
                
                if !isLastItem {
                    Spacer()
                }
            }
        }
    }
    
}

#if DEBUG

struct HourlyForecastWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastWidgetMediumView(locality: "Bordeaux",
                                       date: Date(),
                                       temperatureMin: 0,
                                       temperatureMax: 17,
                                       hourlyForecasts: Array(Forecast.list.prefix(6)))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

#endif
