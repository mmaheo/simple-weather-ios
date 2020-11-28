//
//  SettingsView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                unitRowView
            }
        }
        .navigationTitle(Text("§Settings"))
    }
}

extension SettingsView {
    private var unitRowView: some View {
        NavigationLink(destination: SettingsUnitView(),
                       label: { Label("§Units", systemImage: "globe") })
    }
}

#if DEBUG

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
            
            SettingsView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
    }
}

#endif
