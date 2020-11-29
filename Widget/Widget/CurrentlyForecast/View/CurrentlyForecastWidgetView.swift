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
                let apparentTemperature = entry.apparentTemperature,
                let precipProbability = entry.precipProbability,
                let windSpeed = entry.windSpeed,
                let unit = entry.unit,
                let sunsetTime = entry.sunsetTime
            {
            
            CurrentlyForecastWidgetSmallView(locality: locality,
                                             date: entry.date,
                                             iconSystemName: iconSystemName,
                                             temperature: temperature,
                                             temperatureMin: temperatureMin,
                                             apparentTemperature: apparentTemperature,
                                             precipProbability: precipProbability,
                                             windSpeed: windSpeed,
                                             unit: unit,
                                             sunsetTime: sunsetTime)
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
