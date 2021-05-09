//
//  UserDefaultsService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import Injectable
import Foundation

final class UserDefaultsService: Injectable {
    
    // MARK: - Properties
    
    private let userDefaults: UserDefaults
    
    private let latitudeKey = "latitude_key"
    private let longitudeKey = "longitude_key"
    private let unitKey = "unit_key"
    private let localityKey = "locality_key"
    private let lastRatingDateKey = "last_rating_date_key"
    private let networkCallsKey = "network_calls_key"
    private let sessionsKey = "sessions_key"
    private let lastNetworkCallKey = "last_network_call_key"
    private let currentlyForecastKey = "currently_forecast_key"
    private let hourlyForecastKey = "hourly_forecast_key"
    private let dailyForecastKey = "daily_forecast_key"
    
    // MARK: - Lifecycle
    
    init() {
        if let userDefaults = UserDefaults(suiteName: "group.maxime.maheo.simple-weather") {
            self.userDefaults = userDefaults
        } else {
            self.userDefaults = UserDefaults.standard
        }
    }
    
    // MARK: - Saving Methods
    
    func save(latitude: Double) { userDefaults.setValue(latitude, forKey: latitudeKey) }
    
    func save(longitude: Double) { userDefaults.setValue(longitude, forKey: longitudeKey) }
    
    func save(unit: Unit) { userDefaults.setValue(unit.rawValue, forKey: unitKey) }
    
    func save(locality: String) { userDefaults.setValue(locality, forKey: localityKey) }
    
    func save(lastDateRating: Date) { userDefaults.setValue(lastDateRating.timeIntervalSince1970, forKey: lastRatingDateKey) }
    
    func incrementNetworkCalls() { userDefaults.setValue(fetchNetworkCalls() + 1, forKey: networkCallsKey) }
    
    func incrementSessions() { userDefaults.setValue(fetchSessions() + 1, forKey: sessionsKey) }
    
    func save(lastNetworkCall: TimeInterval) { userDefaults.setValue(lastNetworkCall, forKey: lastNetworkCallKey) }
    
    func save(currentlyForecast: Forecast) {
        guard let encodedObject = try? JSONEncoder().encode(currentlyForecast) else { return }

        userDefaults.set(encodedObject, forKey: currentlyForecastKey)
    }
    
    func save(hourlyForecast: [Forecast]) {
        guard let encodedObject = try? JSONEncoder().encode(hourlyForecast) else { return }

        userDefaults.set(encodedObject, forKey: hourlyForecastKey)
    }
    
    func save(dailyForecast: [Forecast]) {
        guard let encodedObject = try? JSONEncoder().encode(dailyForecast) else { return }

        userDefaults.set(encodedObject, forKey: dailyForecastKey)
    }
    
    // MARK: - Fetching Methods
    
    func fetchLatitude() -> Double? {
        let latitude = userDefaults.double(forKey: latitudeKey)
        
        return latitude == 0 ? nil : latitude
    }
    
    func fetchLongitude() -> Double? {
        let longitude = userDefaults.double(forKey: longitudeKey)
        
        return longitude == 0 ? nil : longitude
    }
    
    func fetchUnit() -> Unit? {
        guard let stringUnit = userDefaults.string(forKey: unitKey) else { return nil }
        
        return Unit(rawValue: stringUnit)
    }
    
    func fetchLocality() -> String? { userDefaults.string(forKey: localityKey) }
    
    func fetchLastDateRating() -> Date? {
        let timeIntervalSince1970 = userDefaults.double(forKey: lastRatingDateKey)
        
        return timeIntervalSince1970 == 0 ? nil : Date(timeIntervalSince1970: timeIntervalSince1970)
    }
    
    func fetchNetworkCalls() -> Int { userDefaults.integer(forKey: networkCallsKey) }
    
    func fetchSessions() -> Int { userDefaults.integer(forKey: sessionsKey) }
    
    func fetchLastNetworkCall() -> TimeInterval { userDefaults.double(forKey: lastNetworkCallKey) }
    
    func fetchCurrentlyForecast() -> Forecast? {
        guard let data = userDefaults.object(forKey: currentlyForecastKey) as? Data,
              let currentlyForecast = try? JSONDecoder().decode(Forecast.self, from: data)
        else { return nil }
        
        return currentlyForecast
    }
    
    func fetchHourlyForecast() -> [Forecast]? {
        guard let data = userDefaults.object(forKey: hourlyForecastKey) as? Data,
              let hourlyForecast = try? JSONDecoder().decode([Forecast].self, from: data)
        else { return nil }
        
        return hourlyForecast
    }
    
    func fetchDailyForecast() -> [Forecast]? {
        guard let data = userDefaults.object(forKey: dailyForecastKey) as? Data,
              let dailyForecast = try? JSONDecoder().decode([Forecast].self, from: data)
        else { return nil }
        
        return dailyForecast
    }
    
}
