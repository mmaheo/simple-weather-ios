//
//  ForecastStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Combine
import Injectable
import Foundation

enum ForecastStoreAction {
    case fetchForecast
}

final class ForecastStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var currently: Forecast?
    @Published private(set) var hourly: [Forecast]
    @Published private(set) var daily: [Forecast]
    @Published private(set) var isLoading: Bool
    
    @Inject private var forecastService: ForecastService
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    init(currently: Forecast? = nil,
         hourly: [Forecast] = [],
         daily: [Forecast] = []) {
        self.currently = currently
        self.hourly = hourly
        self.daily = daily
        self.isLoading = false
    }
    
    // MARK: - Methods
    
    func dispatch(action: ForecastStoreAction) {
        switch action {
        case .fetchForecast:
            fetchForecast()
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchForecast() {
        isLoading = true
        
        forecastService
            .fetchForecast(latitude: 0,
                           longitude: 0)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (completion) in
                guard let self = self else { return }
                
                self.isLoading = false
                
                if case .failure = completion {
                    
                }
            } receiveValue: { [weak self] (response) in
                guard let self = self else { return }
                
                self.currently = response.currently
                self.hourly = response.hourly.data
                self.daily = response.daily.data
            }
            .store(in: &cancellables)
    }
}

#if DEBUG

let forecastStorePreview = ForecastStore(currently: Forecast.one,
                                         hourly: Forecast.list,
                                         daily: Forecast.list)

#endif
