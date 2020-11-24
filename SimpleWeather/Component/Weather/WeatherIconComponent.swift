//
//  WeatherIconComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import SwiftUI

struct WeatherIconComponent: View {
    
    // MARK: - Properties
    
    let iconSystemName: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var hasBackground: Bool {
        colorScheme == .light
    }
    
    // MARK: - Body
    
    var body: some View {
        Image(systemName: iconSystemName)
            .renderingMode(.original)
            .padding(8)
            .background(
                Circle()
                    .fill(Color.black.opacity(hasBackground ? 0.8 : 0))
            )
    }
}

extension WeatherIconComponent {
    
}

#if DEBUG

struct WeatherIconComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherIconComponent(iconSystemName: "sun.max.fill")
            
            WeatherIconComponent(iconSystemName: "cloud.rain.fill")
                .preferredColorScheme(.dark)
            
            WeatherIconComponent(iconSystemName: "cloud.rain.fill")
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

#endif
