//
//  String+FirstLetterCapitalized.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 25/11/2020.
//

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}
