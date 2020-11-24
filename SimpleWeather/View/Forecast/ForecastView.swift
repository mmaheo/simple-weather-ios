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
        ScrollView(.vertical,
                   showsIndicators: true) {
            VStack(spacing: 16) {
                currentlyWeatherView
                hourlyWeatherView
                poweredByDarkSkyView
            }
            .padding(.horizontal, 16)
        }
        .onAppear { forecastStore.dispatch(action: .fetchForecast) }
    }
}

extension ForecastView {
    
    private var currentlyWeatherView: some View {
        forecastStore.currently.map { forecast in
            CurrentlyWeatherComponent(iconSystemName: forecast.wrappedIconSystemName,
                                      temperature: forecast.wrappedTemperature,
                                      apparentTemperature: forecast.wrappedApparentTemperature)
        }
    }
    
    private var hourlyWeatherView: some View {
        forecastStore.hourly.first.map { firstHourlyForecast in
            makeSectionView(title: firstHourlyForecast.wrappedTimeOfTheDay) {
                ForEach(forecastStore.hourly) { forecast in
                    HourlyWeatherComponent(time: forecast.wrappedTime,
                                           temperature: forecast.wrappedTemperature,
                                           iconSystemName: forecast.wrappedIconSystemName,
                                           precipProbability: forecast.wrappedPrecipProbability)
                }
            }
        }
    }
    
    private var poweredByDarkSkyView: some View {
        URL(string: "https://darksky.net/poweredby/").map { url in
            HStack {
                Spacer()
                Link(destination: url) {
                    Text("§Powered by Dark Sky")
                        .font(.caption)
                        .italic()
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
        }
    }
    
}

extension ForecastView {
    private func makeSectionView<T: View>(title: String,
                                          _ content: @escaping () -> T) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
                .accessibility(identifier: "forecast_view_section_title")
            
            ScrollView(.horizontal,
                       showsIndicators: false) {
                HStack(spacing: 8) {
                    content()
                }
            }
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
