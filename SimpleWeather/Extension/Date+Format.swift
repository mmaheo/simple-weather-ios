//
//  Date+Format.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import Foundation

extension Date {
    func format(format: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.preferredLocale()
        
        if format != nil {
            dateFormatter.dateFormat = format
        } else {
            dateFormatter.dateStyle = .medium
        }

        return dateFormatter.string(from: self)
    }
}
