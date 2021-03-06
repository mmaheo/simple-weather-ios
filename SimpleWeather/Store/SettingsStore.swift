//
//  SettingsStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import Foundation
import Injectable
import Combine

enum SettingsViewType {
    case main, unit, privacyPolicy, termsAndConditions
}

enum SettingsStoreAction {
    case fetchUnit,
         change(unit: Unit),
         viewDidAppear
}

final class SettingsStore: ObservableObject {

    // MARK: - Properties
    
    @Published private(set) var unit: Unit
    @Published private(set) var quota: Int
    @Published private(set) var isPremium: Bool = false
    
    @Inject private var userDefaultsService: UserDefaultsService
    @Inject private var purchaseService: PurchaseService
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    
    init(unit: Unit = .si,
         quota: Int = 0) {
        self.unit = unit
        self.quota = quota
    }
    
    // MARK: - Methods
    
    func dispatch(action: SettingsStoreAction) {
        switch action {
        case .fetchUnit: return fetchUnitAction()
        case let .change(unit): return changeUnitAction(unit: unit)
        case .viewDidAppear: return viewDidAppearAction()
        }
    }
    
    // MARK: - Action Methods
    
    private func viewDidAppearAction() {
        quota = userDefaultsService.fetchUserQuota().value
        
        purchaseService
            .isPremiumMember()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isPremium, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchUnitAction() {
        guard let unit = userDefaultsService.fetchUnit() else { return save(unit: .si) }
        
        self.unit = unit
    }
    
    private func changeUnitAction(unit: Unit) { save(unit: unit) }
    
    // MARK: - Private Methods
    
    private func save(unit: Unit) {
        self.unit = unit
        userDefaultsService.save(unit: unit)
    }
}

#if DEBUG

let settingsStorePreview = SettingsStore()

#endif
