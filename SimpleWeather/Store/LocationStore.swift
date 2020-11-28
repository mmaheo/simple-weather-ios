//
//  LocationStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import Foundation
import Injectable
import Combine

final class LocationStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var locality: String
    @Published private(set) var isAuthorizationStatusDenied: Bool

    @Inject private var locationService: LocationService

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    init(locality: String = "",
         isAuthorizationStatusDenied: Bool = false) {
        self.locality = locality
        self.isAuthorizationStatusDenied = isAuthorizationStatusDenied
        
        bindLocality()
        bindIsAuthorizationStatusDenied()
    }
    
    // MARK: - Binding Methods
    
    private func bindLocality() {
        locationService
            .locality
            .receive(on: DispatchQueue.main)
            .assign(to: \.locality, on: self)
            .store(in: &cancellables)
    }
    
    private func bindIsAuthorizationStatusDenied() {
        locationService
            .isAuthorizationStatusDenied
            .receive(on: DispatchQueue.main)
            .assign(to: \.isAuthorizationStatusDenied, on: self)
            .store(in: &cancellables)
    }

}

#if DEBUG

let locationStorePreview = LocationStore(locality: "Bordeaux",
                                         isAuthorizationStatusDenied: false)

#endif
