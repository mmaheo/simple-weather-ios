//
//  ForecastWidgetTimelineProvider.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import WidgetKit
import Combine

final class ForecastWidgetTimelineProvider: TimelineProvider {
    
    typealias Entry = ForecastWidgetEntry
    
    // MARK: - Properties
    
    private let forecastService = ForecastService()
    private let userDefaultsService = UserDefaultsService()
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    func placeholder(in context: Context) -> Entry {
        placeholderEntry()
    }
    
    func getSnapshot(in context: Context,
                     completion: @escaping (Entry) -> Void) {
        getCurrentlyForecastWidgetEntry { (entry) in
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<Entry>) -> Void) {
        getCurrentlyForecastWidgetEntry { (entry) in
            let currentDate = Date()
            let dateToReload = Calendar
                .current
                .date(byAdding: .hour,
                      value: 1,
                      to: currentDate) ?? currentDate
            
            let timelinePolicy = TimelineReloadPolicy.after(dateToReload)
            let timeline = Timeline(entries: [entry],
                                    policy: timelinePolicy)
            
            completion(timeline)
        }
    }
    
    // MARK: - Private Methods
    
    private func getCurrentlyForecastWidgetEntry(completion: @escaping (Entry) -> Void) {
        let unit = userDefaultsService.fetchUnit() ?? .si
        let locality = userDefaultsService.fetchLocality() ?? "§Today"

        guard
            let latitude = userDefaultsService.fetchLatitude(),
            let longitude = userDefaultsService.fetchLongitude()
        else { return completion(placeholderEntry()) }

        forecastService
            .fetchForecast(latitude: latitude,
                           longitude: longitude,
                           unit: unit.rawValue)
            .sink { (_) in

            } receiveValue: { [weak self] (response) in
                guard let self = self else { return }
                
                completion(self.entry(forecast: response.currently,
                                      locality: locality,
                                      unit: unit,
                                      hourlyForecast: response.hourly.data))
            }
            .store(in: &cancellables)
    }
    
    private func placeholderEntry() -> Entry {
        Entry(date: Date())
    }
    
    private func entry(forecast: Forecast,
                       locality: String,
                       unit: Unit,
                       hourlyForecast: [Forecast]) -> Entry {
        Entry(date: Date(),
              locality: locality,
              iconSystemName: forecast.wrappedIconSystemName,
              temperature: forecast.wrappedTemperature,
              temperatureMin: forecast.wrappedTemperatureMin,
              apparentTemperature: forecast.wrappedApparentTemperature,
              precipProbability: forecast.wrappedPrecipProbability,
              windSpeed: forecast.wrappedWindSpeed,
              unit: unit,
              sunsetTime: hourlyForecast.first?.wrappedSunsetTime,
              hourlyForecast: hourlyForecast)

    }
}
