//
//  SKProductSubscriptionPeriod+PeriodTitle.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import Purchases

extension SKProductSubscriptionPeriod {
    var durationTitle: String {
        switch self.unit {
        case .day: return NSLocalizedString("day", comment: "")
        case .week: return NSLocalizedString("week", comment: "")
        case .month: return NSLocalizedString("month", comment: "")
        case .year: return NSLocalizedString("year", comment: "")
        default: return NSLocalizedString("Unknown", comment: "")
        }
    }
    
    var periodTitle: String {
        let periodString = "\(numberOfUnits) \(durationTitle)"
        
        return numberOfUnits > 1 ?  periodString + "s" : periodString
    }
}
