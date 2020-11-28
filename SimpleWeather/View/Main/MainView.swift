//
//  MainView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    // MARK: - Body
    
    var body: some View {
        if horizontalSizeClass == .compact {
            TabBarView()
        } else {
            SideBarView()
        }
    }
}

#if DEBUG

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
            
            MainView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(forecastStorePreview)
    }
}

#endif
