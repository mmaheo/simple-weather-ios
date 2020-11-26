//
//  BoolEncoding.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 26/11/2020.
//

enum BoolEncoding {
    case numeric, literal

    // MARK: - Methods
    
    func encode(value: Bool) -> String {
        switch self {
        case .numeric:
            return value ? "1" : "0"
        case .literal:
            return value ? "true" : "false"
        }
    }
}
