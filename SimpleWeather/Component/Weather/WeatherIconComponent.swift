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
    let isLarge: Bool
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var hasBackground: Bool {
        colorScheme == .light
    }
    
    private var width: CGFloat {
        isLarge ? 50 : 25
    }
    
    private var padding: CGFloat {
        isLarge ? 12 : 8
    }
    
    // MARK: - Body
    
    var body: some View {
        Image(systemName: iconSystemName)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: width,
                   height: width)
            .padding(padding)
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
            WeatherIconComponent(iconSystemName: "sun.max.fill",
                                 isLarge: true)
            
            WeatherIconComponent(iconSystemName: "cloud.rain.fill",
                                 isLarge: false)
                .preferredColorScheme(.dark)
            
            WeatherIconComponent(iconSystemName: "cloud.rain.fill",
                                 isLarge: false)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

#endif
