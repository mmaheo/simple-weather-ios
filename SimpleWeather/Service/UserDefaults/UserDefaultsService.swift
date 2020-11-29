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
    
    // MARK: - Lifecycle
    
    init() {
        if let userDefaults = UserDefaults(suiteName: "group.maxime.maheo.simple-weather") {
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
    
    func save(unit: Unit) {
        userDefaults.setValue(unit.rawValue, forKey: unitKey)
    }
    
    func save(locality: String) {
        userDefaults.setValue(locality, forKey: localityKey)
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
        guard
            let stringUnit = userDefaults.string(forKey: unitKey)
        else { return nil }
        
        return Unit(rawValue: stringUnit)
    }
    
    func fetchLocality() -> String? {
        userDefaults.string(forKey: localityKey)
    }
    
}
