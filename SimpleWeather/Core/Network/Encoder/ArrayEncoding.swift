//
//  ArrayEncoding.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 26/11/2020.
//

enum ArrayEncoding {
    case brackets, noBrackets

    // MARK: - Methods
    
    func encode(key: String) -> String {
        switch self {
        case .brackets:
            return "\(key)[]"
        case .noBrackets:
            return key
        }
    }
}
