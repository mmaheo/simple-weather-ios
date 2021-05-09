//
//  SettingsStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import Foundation
import Injectable

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
    
    @Inject private var userDefaultsService: UserDefaultsService
    
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
    
    private func viewDidAppearAction() { quota = userDefaultsService.fetchNetworkCalls() }
    
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
