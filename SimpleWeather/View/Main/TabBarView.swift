//
//  TabBarView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            NavigationView {
                ForecastView()
            }
            .tabItem {
                Image(systemName: "thermometer")
                Text("§Forecast")
            }
        }
    }
}

#if DEBUG

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarView()
            
            TabBarView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(forecastStorePreview)
        .environmentObject(locationStorePreview)
    }
}

#endif
