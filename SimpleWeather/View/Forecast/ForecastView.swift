//
//  ForecastView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 22/11/2020.
//

import SwiftUI

struct ForecastView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var forecastStore: ForecastStore
    
    // MARK: - Body
    
    var body: some View {
        makeCurrentlyWeatherView()
            .onAppear { forecastStore.dispatch(action: .fetchForecast) }
    }
    
    // MARK: - Methods
    
    private func makeCurrentlyWeatherView() -> some View {
        forecastStore.currently.map { forecast in
            CurrentlyWeatherComponent(iconSystemName: forecast.wrappedIconSystemName,
                                      temperature: forecast.wrappedTemperature,
                                      apparentTemperature: forecast.wrappedApparentTemperature)
        }
    }
}

#if DEBUG

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForecastView()
            
            ForecastView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .environmentObject(forecastStorePreview)
    }
}

#endif
