//
//  SideBarView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SideBarView: View {
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ForecastView()) {
                    Label("§Forecast",
                          systemImage: "thermometer")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("§Simple Weather")
            
            ForecastView()
        }
    }
}

#if DEBUG

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SideBarView()
            
            SideBarView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(forecastStorePreview)
        .environmentObject(locationStorePreview)
    }
}

#endif
