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
    @Published var error: AppError?
    
    @Inject private var forecastService: ForecastService
    @Inject private var locationService: LocationService
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    init(currently: Forecast? = nil,
         hourly: [Forecast] = [],
         daily: [Forecast] = [],
         isLoading: Bool = false) {
        self.currently = currently
        self.hourly = hourly
        self.daily = daily
        self.isLoading = isLoading
        
        bindLocation()
    }
    
    // MARK: - Methods
    
    func dispatch(action: ForecastStoreAction) {
        switch action {
        case .fetchForecast:
            fetchForecastAction()
        }
    }
    
    // MARK: - Action Methods
    
    private func fetchForecastAction() {
        isLoading = true
        locationService.fetchLocation()
    }
    
    // MARK: - Binding Methods
    
    private func bindLocation() {
        locationService
            .location
            .flatMap { self.forecastService.fetchForecast(latitude: $0.coordinate.latitude,
                                                          longitude: $0.coordinate.longitude)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (completion) in
                guard let self = self else { return }

                if case let .failure(error) = completion {
                    self.isLoading = false
                    self.error = AppError(error: error)
                }
            } receiveValue: { [weak self] (response) in
                guard let self = self else { return }

                self.isLoading = false
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
                                         daily: Forecast.list,
                                         isLoading: false)

#endif
