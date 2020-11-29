//
//  HourlyForecastWidgetView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct HourlyForecastWidgetView: View {
    
    // MARK: - Properties
    
    let entry: ForecastWidgetTimelineProvider.Entry
    
    @Environment(\.widgetFamily) private var family: WidgetFamily

    private let numberOfItems = 6
    
    // MARK: - Body
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall, .systemLarge:
            WidgetNotAvailableView()
        case .systemMedium:
            if
                let locality = entry.locality,
                entry.hourlyForecast.count >= numberOfItems
            {
            
                HourlyForecastWidgetMediumView(locality: locality,
                                               date: entry.date,
                                               hourlyForecast: Array(entry.hourlyForecast.prefix(numberOfItems)))
            } else {
                WidgetNotAvailableView()
            }
        @unknown default:
            WidgetNotAvailableView()
        }
    }

}
