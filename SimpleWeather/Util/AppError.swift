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
    
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let dimissActionTitle: LocalizedStringKey
    
    // MARK: - Lifecycle
    
    init(error: Error) {
        if case ApiRequesterError.noInternetConnection = error {
            title = "error_network_title"
            message = "error_network_message"
        } else {
            title = "error_generic_title"
            message = "error_generic_message"
        }
        
        dimissActionTitle = "error_dismiss_action_title"
    }
}
