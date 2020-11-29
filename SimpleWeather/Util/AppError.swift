//
//  AppError.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI

struct AppError: Identifiable {
    
    // MARK: - Properties
    
    let id = UUID()
    
    let title: String
    let message: String
    let dimissActionTitle: String
    
    // MARK: - Lifecycle
    
    init(error: Error) {
        if case ApiRequesterError.noInternetConnection = error {
            title = "§Network error"
            message = "§Looks like you're not connected to the internet. Please enable WiFi or check your settings."
        } else {
            title = "§An error occurred"
            message = "§Something went wrong. Please try again later."
        }
        
        dimissActionTitle = "§Got it !"
    }
}
