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
                .padding(.horizontal, 16)
        }
    }
    
    private var hourlyWeatherView: some View {
        forecastStore.hourly.first.map { firstHourlyForecast in
            makeSectionView(title: LocalizedStringKey(firstHourlyForecast.wrappedTimeOfTheDay)) {
            makeSectionView(title: firstHourlyForecast.wrappedTimeOfTheDay) {
                ForEach(forecastStore.hourly) { forecast in
                    let isInFirstPosition = forecastStore.hourly.first == forecast
                    let isInLastPosition = forecastStore.hourly.last == forecast
                    
                    HourlyWeatherComponent(time: forecast.wrappedTime,
                                           temperature: forecast.wrappedTemperature,
                                           iconSystemName: forecast.wrappedIconSystemName,
                                           precipProbability: forecast.wrappedPrecipProbability)
                        .padding(.leading, isInFirstPosition ? 16 : 0)
                        .padding(.trailing, isInLastPosition ? 16 : 0)
                }
            }
        }
    }
    
    private var dailyWeatherView: some View {
        makeSectionView(title: "§This week") {
            ForEach(forecastStore.daily) { forecast in
                let isInFirstPosition = forecastStore.daily.first == forecast
                let isInLastPosition = forecastStore.daily.last == forecast

                DailyWeatherComponent(time: forecast.wrappedTime,
                                      iconSystemName: forecast.wrappedIconSystemName,
                                      summary: forecast.wrappedSummary,
                                      temperatureMin: forecast.wrappedTemperatureMin,
                                      temperatureMax: forecast.wrappedTemperatureMax,
                                      humidity: forecast.wrappedHumidity,
                                      precipProbability: forecast.wrappedPrecipProbability,
                                      uvIndex: forecast.wrappedUVIndex,
                                      windSpeed: forecast.wrappedWindSpeed,
                                      sunriseTime: forecast.wrappedSunriseTime,
                                      sunsetTime: forecast.wrappedSunsetTime)
                    .padding(.leading, isInFirstPosition ? 16 : 0)
                    .padding(.trailing, isInLastPosition ? 16 : 0)
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
                .padding(.horizontal)
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
