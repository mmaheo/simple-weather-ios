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
    let hourlyForecast: [Forecast]
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            localityView
            Spacer()
            forecastView
        }
        .padding()
    }
}

extension HourlyForecastWidgetMediumView {
    
    private var localityView: some View {
        HStack(alignment: .center) {
            Text(locality)
                .font(.headline)
                .lineLimit(1)
            
            Spacer()
            
            dateView
        }
    }
    
    private var dateView: some View {
        Text(date.format(format: "HH:mm"))
            .font(.system(size: 10))
            .foregroundColor(.gray)
    }
    
    private var forecastView: some View {
        HStack(spacing: 16) {
            ForEach(hourlyForecast) { forecast in
                HourlyWeatherComponent(time: forecast.wrappedTime,
                                       temperature: forecast.wrappedTemperature,
                                       iconSystemName: forecast.wrappedIconSystemName,
                                       precipProbability: forecast.wrappedPrecipProbability,
                                       isWidget: true)
            }
        }
    }
    
}

#if DEBUG

struct HourlyForecastWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastWidgetMediumView(locality: "Bordeaux",
                                       date: Date(),
                                       hourlyForecast: Array(Forecast.list.prefix(6)))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

#endif
