//
//  UIApplication+CurrentScene.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import UIKit

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
