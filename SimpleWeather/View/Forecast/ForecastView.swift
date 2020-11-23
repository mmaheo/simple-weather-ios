//
//  ForecastView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 22/11/2020.
//

import SwiftUI

struct ForecastView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForecastView()
            
            ForecastView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
    }
}
