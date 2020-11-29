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
    @EnvironmentObject private var locationStore: LocationStore
    @EnvironmentObject private var settingsStore: SettingsStore
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var dailyWeatherLayout: [GridItem] {
        horizontalSizeClass == .compact ?
            [GridItem(.flexible(), spacing: 16)] :
            [GridItem(.adaptive(minimum: 250), spacing: 16)]
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: true) {
            if locationStore.isAuthorizationStatusDenied {
                LocationDisabledComponent()
            } else if forecastStore.isLoading {
                ProgressView("§Loading")
            } else {
                contentView
            }
        }
        .navigationTitle(locationStore.locality)
        .alert(item: $forecastStore.error) { error in
            Alert(title: Text(error.title),
                  message: Text(error.message),
                  dismissButton: .default(Text(error.dimissActionTitle)))
        }
        .onAppear {
            settingsStore.dispatch(action: .fetchUnit)
            forecastStore.dispatch(action: .fetchForecast)
        }
    }
}

extension ForecastView {
    
    private var contentView: some View {
        VStack(spacing: 16) {
            currentlyWeatherView
            hourlyWeatherView
            dailyWeatherView
            poweredByDarkSkyView
        }
    }
    
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
            makeSectionView(title: firstHourlyForecast.wrappedTimeOfTheDay) {
                ScrollView(.horizontal,
                           showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(forecastStore.hourly) { forecast in
                            let isInFirstPosition = forecastStore.hourly.first == forecast
                            let isInLastPosition = forecastStore.hourly.last == forecast
                            
                            HourlyWeatherComponent(time: forecast.wrappedTime,
                                                   temperature: forecast.wrappedTemperature,
                                                   iconSystemName: forecast.wrappedIconSystemName,
                                                   precipProbability: forecast.wrappedPrecipProbability)
                                .padding(.leading, isInFirstPosition ? 16 : 0)
                                .padding(.trailing, isInLastPosition ? 16 : 0)
                                .fixedSize()
                        }
                    }
                }
            }
        }
    }
    
    private var dailyWeatherView: some View {
        makeSectionView(title: "§This week") {
            LazyVGrid(columns: dailyWeatherLayout,
                      spacing: 16) {
                ForEach(forecastStore.daily) { forecast in
                    DailyWeatherComponent(time: forecast.wrappedTime,
                                          iconSystemName: forecast.wrappedIconSystemName,
                                          summary: forecast.wrappedSummary,
                                          temperatureMin: forecast.wrappedTemperatureMin,
                                          temperatureMax: forecast.wrappedTemperatureMax,
                                          humidity: forecast.wrappedHumidity,
                                          precipProbability: forecast.wrappedPrecipProbability,
                                          uvIndex: forecast.wrappedUVIndex,
                                          windSpeed: forecast.wrappedWindSpeed,
                                          unit: settingsStore.unit,
                                          sunriseTime: forecast.wrappedSunriseTime,
                                          sunsetTime: forecast.wrappedSunsetTime)
                }
            }
            .padding(.horizontal, 16)
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
        .padding(.horizontal, 16)
        .padding(.bottom)
    }
    
}

extension ForecastView {
    private func makeSectionView<T: View>(title: String,
                                          _ content: @escaping () -> T) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
                .padding(.horizontal, 16)
                .accessibility(identifier: "forecast_view_section_title")
            
            content()
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
        .environmentObject(locationStorePreview)
    }
}

#endif
