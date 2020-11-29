//
//  SimpleWeatherWidget.swift
//  Widget
//
//  Created by Maxime Maheo on 29/11/2020.
//

import SwiftUI

@main
struct SimpleWeatherWidget: WidgetBundle {
    
    // MARK: - Body
    
    @WidgetBundleBuilder
    var body: some Widget {
        CurrentlyForecastWidget()
        HourlyForecastWidget()
    }
    
}
