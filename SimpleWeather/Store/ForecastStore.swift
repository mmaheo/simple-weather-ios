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
    case forecastViewDidAppear
}

final class ForecastStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var currently: Forecast?
    @Published private(set) var hourly: [Forecast]
    @Published private(set) var daily: [Forecast]
    @Published private(set) var isLoading: Bool
    @Published private(set) var cachedLocality: String = ""
    @Published var error: AppError?
    @Published var isShowingPaywall: Bool = false
    
    @Inject private var forecastService: ForecastService
    @Inject private var locationService: LocationService
    @Inject private var userDefaultsService: UserDefaultsService
    @Inject private var purchaseService: PurchaseService
    
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
        case .forecastViewDidAppear: return forecastViewDidAppearAction()
        }
    }
    
    // MARK: - Action Methods
    
    private func forecastViewDidAppearAction() {
        let now = Date().timeIntervalSince1970
        
        purchaseService
            .isPremiumMember()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPremiumMember in
                guard let self = self else { return }
                
                if !isPremiumMember && self.userDefaultsService.fetchUserQuota().value >= Constant.quota {
                    self.isShowingPaywall = true
                }
            }
            .store(in: &cancellables)
        
        if now - userDefaultsService.fetchLastNetworkCall() <= Constant.refreshRate,
           let currently = userDefaultsService.fetchCurrentlyForecast(),
           let hourly = userDefaultsService.fetchHourlyForecast(),
           let daily = userDefaultsService.fetchDailyForecast() {
            return usedCachedForecast(currently: currently, hourly: hourly, daily: daily)
        }
        
        userDefaultsService.save(lastNetworkCall: now)
        userDefaultsService.incrementUserQuota()
        
        fetchLocation()
    }
    
    // MARK: - Binding Methods
    
    private func bindLocation() {
        locationService
            .location
            .flatMap { self.forecastService.fetchForecast(latitude: $0.coordinate.latitude,
                                                          longitude: $0.coordinate.longitude,
                                                          unit: self.userDefaultsService.fetchUnit() ?? .si) }
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
                
                self.userDefaultsService.save(currentlyForecast: response.currently)
                self.userDefaultsService.save(hourlyForecast: response.hourly.data)
                self.userDefaultsService.save(dailyForecast: response.daily.data)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Methods
    
    private func fetchLocation() {
        isLoading = true
        locationService.fetchLocation()
    }
    
    private func usedCachedForecast(currently: Forecast, hourly: [Forecast], daily: [Forecast]) {
        self.currently = currently
        self.hourly = hourly
        self.daily = daily
        cachedLocality = userDefaultsService.fetchLocality() ?? ""
    }
}

#if DEBUG

let forecastStorePreview = ForecastStore(currently: Forecast.one,
                                         hourly: Forecast.list,
                                         daily: Forecast.list,
                                         isLoading: false)

#endif
