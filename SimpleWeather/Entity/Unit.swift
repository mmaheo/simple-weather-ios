//
//  Unit.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

// swiftlint:disable identifier_name
enum Unit: String {
    case ca, us, si
    case uk = "uk2"
    
    var windSpeedUnit: String {
        switch self {
        case .ca:
            return "km/h"
        case .uk, .us:
            return "mph"
        case .si:
            return "m/s"
        }
    }
}
// swiftlint:enable identifier_name
