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
    case settingsViewDidAppear(type: SettingsViewType)
    case fetchUnit
    case change(unit: Unit)
}

final class SettingsStore: ObservableObject {

    // MARK: - Properties
    
    @Published private(set) var unit: Unit
    
    @Inject private var userDefaultsService: UserDefaultsService
    @Inject private var analyticsService: AnalyticsService
    
    // MARK: - Lifecycle
    
    init(unit: Unit = .si) {
        self.unit = unit
    }
    
    // MARK: - Methods
    
    func dispatch(action: SettingsStoreAction) {
        switch action {
        case let .settingsViewDidAppear(type):
            settingsViewDidAppearAction(type: type)
        case .fetchUnit:
            fetchUnitAction()
        case let .change(unit):
            changeUnitAction(unit: unit)
        }
    }
    
    // MARK: - Action Methods
    
    private func settingsViewDidAppearAction(type: SettingsViewType) {
        switch type {
        case .main:
            analyticsService.logScreenView(event: AppAnalyticsScreenView.settingsView)
        case .unit:
            analyticsService.logScreenView(event: AppAnalyticsScreenView.settingsUnitView)
        case .privacyPolicy:
            analyticsService.logScreenView(event: AppAnalyticsScreenView.settingsPrivacyPolicyView)
        case .termsAndConditions:
            analyticsService.logScreenView(event: AppAnalyticsScreenView.settingsTermsAndConditionsView)
        }
    }
    
    private func fetchUnitAction() {
        guard
            let unit = userDefaultsService.fetchUnit()
        else { return save(unit: .si) }
        
        self.unit = unit
    }
    
    private func changeUnitAction(unit: Unit) {
        analyticsService.logEvent(event: AppAnalyticsEvent.changeUnit(unit: unit))
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
