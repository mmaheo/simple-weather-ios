//
//  TabBarView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK: - Properties
    
    @State private var selection: Tab = .forecast

    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ForecastView()
            }
            .tabItem {
                Label("§Forecast",
                      systemImage: "thermometer")
            }
            .tag(Tab.forecast)
        }
    }
}

extension TabBarView {
    enum Tab {
        case forecast
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
