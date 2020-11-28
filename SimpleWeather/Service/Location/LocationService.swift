//
//  LocationService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import Injectable
import CoreLocation
import Combine

final class LocationService: NSObject, Injectable {

    // MARK: - Properties

    let location = PassthroughSubject<CLLocation, Never>()
    let locality = PassthroughSubject<String, Never>()
    
    private let manager = CLLocationManager()
    private var lastLocation: CLLocation?
    private var cancellables = Set<AnyCancellable>()
    
    private weak var userDefaultService: UserDefaultsService?

    // MARK: - Lifecycle
    
    init(userDefaultService: UserDefaultsService) {
        super.init()
        
        self.userDefaultService = userDefaultService
        
        manager.delegate = self
        
        bindLocation()
    }
    
    // MARK: - Methods
    
    func fetchLocation() {
        requestLastLocation()
        
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    // MARK: - Private Methods
    
    private func saveLastLocation(location: CLLocation) {
        userDefaultService?.save(latitude: location.coordinate.latitude)
        userDefaultService?.save(longitude: location.coordinate.longitude)
    }
    
    private func requestLastLocation() {
        guard
            let latitude = userDefaultService?.fetchLatitude(),
            let longitude = userDefaultService?.fetchLongitude()
        else { return }
        
        let lastLocation = CLLocation(latitude: latitude,
                                      longitude: longitude)
        self.lastLocation = lastLocation
        
        location.send(lastLocation)
    }
    
    private func sendLocationIfNeeded(location: CLLocation) {
        guard
            let lastLocation = lastLocation
        else { return self.location.send(location) }
        
        if lastLocation.distance(from: location) >= 1000 * 10 { // 10 km
            self.location.send(location)
        }
    }
    
    private func fetchLocality(location: CLLocation) {
        CLGeocoder()
            .reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                guard
                    error == nil,
                    let self = self,
                    let locality = placemarks?.first?.locality
                else { return }

                self.locality.send(locality)
            }
    }
    
    // MARK: - Binding Methods
    
    private func bindLocation() {
        location
            .sink { [weak self] (location) in
                guard let self = self else { return }
                
                self.fetchLocality(location: location)
            }
            .store(in: &cancellables)
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard
            let location = locations.first
        else { return }
        
        saveLastLocation(location: location)
        
        sendLocationIfNeeded(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) { }
    
}
