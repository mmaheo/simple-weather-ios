//
//  SettingsUnitView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SettingsUnitView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    // MARK: - Body
    
    var body: some View {
        Form {
            caUnitView
            ukUnitView
            usUnitView
            siUnitView
        }
        .onAppear {
            settingsStore.dispatch(action: .fetchUnit)
        }
        .navigationTitle("units")
    }
}

extension SettingsUnitView {
    
    private var caUnitView: some View {
        makeRowView(action: { settingsStore.dispatch(action: .change(unit: .ca)) },
                    icon: "🇨🇦",
                    title: "canada",
                    subtitle: "canada_units",
                    isSelected: settingsStore.unit == .ca)
    }
    
    private var ukUnitView: some View {
        makeRowView(action: { settingsStore.dispatch(action: .change(unit: .uk)) },
                    icon: "🇬🇧",
                    title: "uk",
                    subtitle: "uk_units",
                    isSelected: settingsStore.unit == .uk)
    }
    
    private var usUnitView: some View {
        makeRowView(action: { settingsStore.dispatch(action: .change(unit: .us)) },
                    icon: "🇺🇸",
                    title: "us",
                    subtitle: "us_units",
                    isSelected: settingsStore.unit == .us)
    }
    
    private var siUnitView: some View {
        makeRowView(action: { settingsStore.dispatch(action: .change(unit: .si)) },
                    icon: "🌍",
                    title: "si",
                    subtitle: "si_units",
                    isSelected: settingsStore.unit == .si)
    }
    
}

extension SettingsUnitView {
    
    private func makeRowView(action: @escaping () -> Void,
                             icon: String,
                             title: LocalizedStringKey,
                             subtitle: LocalizedStringKey,
                             isSelected: Bool) -> some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(icon)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.body)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
    
}

#if DEBUG

struct SettingsUnitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsUnitView()
            
            SettingsUnitView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .environmentObject(settingsStorePreview)
    }
}

#endif
