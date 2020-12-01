//
//  AnalyticsService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 01/12/2020.
//

import Injectable
import Firebase

protocol AnalyticsEvent {
    var name: String { get }
    var params: [String: Any]? { get }
}

final class AnalyticsService: Injectable {

    // MARK: - Methods
    
    func logEvent(event: AnalyticsEvent) {
        Analytics.logEvent(event.name,
                           parameters: event.params)
    }
    
    func logScreenView(event: AnalyticsEvent) {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: event.name])
    }
    
}
