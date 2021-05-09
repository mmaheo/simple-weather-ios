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
    @EnvironmentObject private var ratingStore: RatingStore
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @State private var isShowingPaywall = true
    
    private var dailyWeatherLayout: [GridItem] {
        horizontalSizeClass == .compact ?
            [GridItem(.flexible(), spacing: 16)] :
            [GridItem(.adaptive(minimum: 250), spacing: 16)]
    }
    
    private var hourlyTemperatureMin: Int {
        forecastStore
            .hourly
            .map { $0.wrappedTemperature }
            .min() ?? 0
    }
    
    private var hourlyTemperatureMax: Int {
        forecastStore
            .hourly
            .map { $0.wrappedTemperature }
            .max() ?? 0
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: true) {
            if locationStore.isAuthorizationStatusDenied {
                LocationDisabledComponent()
            } else if forecastStore.isLoading {
                ProgressView("loading")
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
            forecastStore.dispatch(action: .forecastViewDidAppear)
            ratingStore.dispatch(action: .requestReview(force: false))
        }
        .sheet(isPresented: $isShowingPaywall) {
            PaywallView(isShowingPaywall: $isShowingPaywall)
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
                    HStack(spacing: 0) {
                        ForEach(forecastStore.hourly) { forecast in
                            HourlyWeatherComponent(time: forecast.wrappedTime,
                                                   temperature: forecast.wrappedTemperature,
                                                   temperatureMin: hourlyTemperatureMin,
                                                   temperatureMax: hourlyTemperatureMax,
                                                   iconSystemName: forecast.wrappedIconSystemName,
                                                   precipProbability: forecast.wrappedPrecipProbability)
                        }
                    }
                }
            }
        }
    }
    
    private var dailyWeatherView: some View {
        makeSectionView(title: "this_week") {
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
                    Text("powered_by_dark_sky")
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
    private func makeSectionView<T: View>(title: LocalizedStringKey,
                                          _ content: @escaping () -> T) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .bold()
                .padding(.horizontal, 16)

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
        .environmentObject(settingsStorePreview)
        .environmentObject(ratingStorePreview)
    }
}

#endif
