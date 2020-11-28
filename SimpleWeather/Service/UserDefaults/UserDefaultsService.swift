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
    
    // MARK: - Lifecycle
    
    init() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
           let userDefaults = UserDefaults(suiteName: "group.\(bundleIdentifier)") {
            self.userDefaults = userDefaults
        } else {
            self.userDefaults = UserDefaults.standard
        }
    }
    
    // MARK: - Saving Methods
    
    func save(latitude: Double) {
        userDefaults.setValue(latitude, forKey: latitudeKey)
    }
    
    func save(longitude: Double) {
        userDefaults.setValue(longitude, forKey: longitudeKey)
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
    
}
