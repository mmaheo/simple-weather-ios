//
//  HourlyForecastWidget.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct HourlyForecastWidget: Widget {
    
    // MARK: - Body
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "HourlyForecastWidget",
                            provider: ForecastWidgetTimelineProvider()) { entry in
            HourlyForecastWidgetView(entry: entry)
        }
        .configurationDisplayName("hourly_forecast_widget_title")
        .description("hourly_forecast_widget_description")
        .supportedFamilies([.systemMedium])
    }
}
