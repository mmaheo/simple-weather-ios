//
//  SettingsView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var ratingStore: RatingStore
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                unitRowView
            }
            
            Section(footer: sectionFooterView) {
                ratingRowView
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
    
    private var ratingRowView: some View {
        Button(action: { ratingStore.dispatch(action: .requestReview(force: true)) },
               label: { Label("§Rate the app", systemImage: "star.fill") })
    }
    
    private var sectionFooterView: some View {
        HStack {
            Spacer()
            
            if let url = URL(string: "https://www.linkedin.com/in/maxime-maheo-120907a8/") {
                Link(destination: url,
                     label: { madeByView })
            } else {
                madeByView
            }
            
            Spacer()
        }
    }
    
    private var madeByView: some View {
        Text("§Made with ❤️ by Maxime Maheo")
            .italic()
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
        .environmentObject(ratingStorePreview)
    }
}

#endif
