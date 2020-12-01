//
//  CurrentlyForecastWidget.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct CurrentlyForecastWidget: Widget {
    
    // MARK: - Body
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "CurrentlyForecastWidget",
                            provider: ForecastWidgetTimelineProvider()) { entry in
            CurrentlyForecastWidgetView(entry: entry)
        }
        .configurationDisplayName("currently_forecast_widget_title")
        .description("currently_forecast_widget_description")
        .supportedFamilies([.systemSmall])
    }
}
