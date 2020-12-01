//
//  LocationDisabledComponent.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct LocationDisabledComponent: View {
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Text("location_disabled_title")
                .font(.largeTitle)
                .bold()
            
            Text("location_disabled_message")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#if DEBUG

struct LocationDisabledComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationDisabledComponent()
            
            LocationDisabledComponent()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
    }
}

#endif
