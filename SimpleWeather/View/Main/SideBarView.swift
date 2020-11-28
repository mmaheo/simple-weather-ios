//
//  SideBarView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SideBarView: View {
    
    // MARK: - Properties
    
    @State private var selection: NavigationItem? = .forecast

    // MARK: - Body
    
    var body: some View {
        NavigationView {
            sideBarView
                
            Text("§Select a category")
                .foregroundColor(.secondary)
        }
    }
}

extension SideBarView {
    
    private var sideBarView: some View {
        List(selection: $selection) {
            NavigationLink(destination: ForecastView(),
                           tag: NavigationItem.forecast,
                           selection: $selection) {
                Label("§Forecast",
                      systemImage: "thermometer")
            }
            .tag(NavigationItem.forecast)
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("§Simple Weather")
    }
    
}

extension SideBarView {
    enum NavigationItem {
        case forecast
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
