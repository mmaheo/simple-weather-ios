//
//  WeatherIconComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 23/11/2020.
//

import SwiftUI

enum WeatherIconSize: CGFloat {
    case verySmall = 15
    case small = 20
    case normal = 25
    case large = 50
}

struct WeatherIconComponent: View {
    
    // MARK: - Properties
    
    let iconSystemName: String
    let size: WeatherIconSize
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var hasBackground: Bool {
        colorScheme == .light
    }
    
    private var padding: CGFloat {
        switch size {
        case .verySmall, .small, .normal:
            return 8
        case .large:
            return 16
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        Image(systemName: iconSystemName)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: size.rawValue,
                   height: size.rawValue)
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
                                 size: .small)
            
            WeatherIconComponent(iconSystemName: "sun.max.fill",
                                 size: .normal)
                
            WeatherIconComponent(iconSystemName: "sun.max.fill",
                                 size: .large)
                
            WeatherIconComponent(iconSystemName: "cloud.rain.fill",
                                 size: .normal)
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .previewLayout(.sizeThatFits)
    }
}

#endif
