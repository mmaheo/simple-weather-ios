//
//  CurrentlyForecastWidgetView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI
import WidgetKit

struct CurrentlyForecastWidgetView: View {
    
    // MARK: - Properties
    
    let entry: ForecastWidgetTimelineProvider.Entry
    
    @Environment(\.widgetFamily) private var family: WidgetFamily

    // MARK: - Body
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            if
                let locality = entry.locality,
                let iconSystemName = entry.iconSystemName,
                let temperature = entry.temperature,
                let temperatureMin = entry.temperatureMin,
                let temperatureMax = entry.temperatureMax,
                let apparentTemperature = entry.apparentTemperature
            {
            
            CurrentlyForecastWidgetSmallView(locality: locality,
                                             date: entry.date,
                                             iconSystemName: iconSystemName,
                                             temperature: temperature,
                                             temperatureMin: temperatureMin,
                                             temperatureMax: temperatureMax,
                                             apparentTemperature: apparentTemperature)
            } else {
                WidgetNotAvailableView()
            }
        case .systemMedium, .systemLarge:
            WidgetNotAvailableView()
        @unknown default:
            WidgetNotAvailableView()
        }
    }

}
