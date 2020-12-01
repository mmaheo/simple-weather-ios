//
//  AnalyticsEvent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 01/12/2020.
//

enum AppAnalyticsEvent: AnalyticsEvent {
    
    case fetchForecast
    case changeUnit(unit: Unit)
    case rateTheApp
    
    var name: String {
        "uaevent"
    }
    
    var params: [String: Any]? {
        switch self {
        case .fetchForecast:
            return ["name": "fetch-forecast"]
        case let .changeUnit(unit):
            return ["name": "change-unit",
                    "unit": unit.rawValue]
        case .rateTheApp:
            return ["name": "rate-the-app"]
        }
    }
    
}
