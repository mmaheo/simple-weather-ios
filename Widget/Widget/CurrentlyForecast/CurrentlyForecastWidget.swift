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
                            provider: CurrentlyForecastWidgetTimelineProvider()) { entry in
            CurrentlyForecastWidgetView(entry: entry)
        }
        .configurationDisplayName("§Current forecast")
        .description("§See the current weather.")
        .supportedFamilies([.systemSmall])
    }
}

