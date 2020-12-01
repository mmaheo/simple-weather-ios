//
//  AppAnalyticsScreenView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 01/12/2020.
//

enum AppAnalyticsScreenView: AnalyticsEvent {
    
    case forecastView
    case settingsView
    case settingsUnitView
    case settingsPrivacyPolicyView
    case settingsTermsAndConditionsView
    
    var name: String {
        switch self {
        case .forecastView:
            return "forecast"
        case .settingsView:
            return "settings"
        case .settingsUnitView:
            return "settings-unit"
        case .settingsPrivacyPolicyView:
            return "settings-privacy-policy"
        case .settingsTermsAndConditionsView:
            return "settings-terms-and-conditions"
        }
    }
    
    var params: [String: Any]? {
        nil
    }
    
}
