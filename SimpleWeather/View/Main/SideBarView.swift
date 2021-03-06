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
                
            Text("select_a_view")
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
                Label("forecast_view_title",
                      systemImage: "thermometer")
            }
            .tag(NavigationItem.forecast)
            
            NavigationLink(destination: SettingsView(),
                           tag: NavigationItem.settings,
                           selection: $selection) {
                Label("settings_view_title",
                      systemImage: "gearshape")
            }
            .tag(NavigationItem.settings)
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("sidebar_app_title")
    }
    
}

extension SideBarView {
    enum NavigationItem {
        case forecast, settings
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
