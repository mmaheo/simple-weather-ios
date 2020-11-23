//
//  Locale+Language.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Foundation

extension Locale {
    
    static func preferredLocale(preferredLanguages: [String] = Locale.preferredLanguages) -> Locale {
        guard let preferredIdentifier = preferredLanguages.first else {
            return current
        }
        
        return Locale(identifier: preferredIdentifier)
    }
    
}
