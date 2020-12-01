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
    @EnvironmentObject private var settingsStore: SettingsStore
    
    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                unitRowView
            }
            
            Section(footer: sectionFooterView) {
                ratingRowView
                exploreMyProjectView
                privacyPolicyView
                termsAndConditionView
            }
        }
        .onAppear {
            settingsStore.dispatch(action: .settingsViewDidAppear(type: .main))
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
               label: { Label("§Rate the app", systemImage: "star") })
    }
    
    private var exploreMyProjectView: some View {
        URL(string: "https://github.com/mmaheo/simple-weather-ios").map {
            Link(destination: $0,
                 label: { Label("§Explore my project", systemImage: "safari") })
        }
        
    }
    
    private var privacyPolicyView: some View {
        NavigationLink(destination: SettingsPrivacyPolicyView(),
                       label: { Label("§Privacy Policy", systemImage: "lock.shield") })
    }
    
    private var termsAndConditionView: some View {
        NavigationLink(destination: SettingsTermsAndConditionsView(),
                       label: { Label("§Terms & Conditions", systemImage: "doc.text") })
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
        .environmentObject(settingsStorePreview)
    }
}

#endif
