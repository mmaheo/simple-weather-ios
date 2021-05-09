//
//  SettingsView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var settingsStore: SettingsStore
    @State private var isShowingPaywall = false

    // MARK: - Body
    
    var body: some View {
        Form {
            Section {
                unitRowView
            }
            
            Section(footer: sectionFooterView) {
                ratingRowView
                privacyPolicyView
                termsAndConditionView
            }
            
            Section(header: Text("subcription"),
                    footer: Text("Quota \(settingsStore.quota)/\(Constant.quota)")) {
                Button(action: {
                    isShowingPaywall = true
                }, label: {
                    Text("become_premium_member")
                })
            }
        }
        .sheet(isPresented: $isShowingPaywall) { PaywallView(isShowingPaywall: $isShowingPaywall).environmentObject(PaywallStore()) }
        .onAppear { settingsStore.dispatch(action: .viewDidAppear) }
        .navigationTitle("settings_view_title")
    }
}

extension SettingsView {
    
    private var unitRowView: some View {
        NavigationLink(destination: SettingsUnitView(),
                       label: { Label("units", systemImage: "globe") })
            .accessibility(identifier: "units_settings_link")
    }
    
    private var ratingRowView: some View {
        URL(string: "https://apps.apple.com/app/simple-weather/id1542742219").map {
            Link(destination: $0,
                 label: { Label("rate_the_app", systemImage: "star") })
        }
    }
    
    private var privacyPolicyView: some View {
        NavigationLink(destination: SettingsPrivacyPolicyView(),
                       label: { Label("privacy_policy", systemImage: "lock.shield") })
    }
    
    private var termsAndConditionView: some View {
        NavigationLink(destination: SettingsTermsAndConditionsView(),
                       label: { Label("terms_and_conditions", systemImage: "doc.text") })
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
        Text("made_by_maxime_maheo")
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
        .environmentObject(settingsStorePreview)
        .environmentObject(paywallStorePreview)
    }
}

#endif
