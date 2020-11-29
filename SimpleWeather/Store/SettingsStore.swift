//
//  SettingsStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import Foundation
import Injectable

enum SettingsStoreAction {
    case fetchUnit
    case change(unit: Unit)
}

final class SettingsStore: ObservableObject {

    // MARK: - Properties
    
    @Published private(set) var unit: Unit
    
    @Inject private var userDefaultsService: UserDefaultsService
    
    // MARK: - Lifecycle
    
    init(unit: Unit = .si) {
        self.unit = unit
    }
    
    // MARK: - Methods
    
    func dispatch(action: SettingsStoreAction) {
        switch action {
        case .fetchUnit:
            fetchUnitAction()
        case let .change(unit):
            changeUnitAction(unit: unit)
        }
    }
    
    // MARK: - Action Methods
    
    private func fetchUnitAction() {
        guard
            let unit = userDefaultsService.fetchUnit()
        else { return save(unit: .si) }
        
        self.unit = unit
    }
    
    private func changeUnitAction(unit: Unit) {
        save(unit: unit)
    }
    
    // MARK: - Private Methods
    
    private func save(unit: Unit) {
        self.unit = unit
        userDefaultsService.save(unit: unit)
    }
}

#if DEBUG

let settingsStorePreview = SettingsStore(unit: .si)

#endif
