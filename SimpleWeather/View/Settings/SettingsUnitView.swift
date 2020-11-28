//
//  SettingsUnitView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 28/11/2020.
//

import SwiftUI

struct SettingsUnitView: View {
    
    // MARK: - Body
    
    var body: some View {
        Form {
            caUnitView
            ukUnitView
            usUnitView
            siUnitView
        }
        .navigationTitle(Text("§Units"))
    }
}

extension SettingsUnitView {
    
    private var caUnitView: some View {
        makeRowView(action: { },
                    icon: "🇨🇦",
                    title: "§Canada",
                    subtitle: "§Celsius, Kilometers, KM/H",
                    isSelected: false)
    }
    
    private var ukUnitView: some View {
        makeRowView(action: { },
                    icon: "🇬🇧",
                    title: "§UK",
                    subtitle: "§Celsius, Miles, MPH",
                    isSelected: false)
    }
    
    private var usUnitView: some View {
        makeRowView(action: { },
                    icon: "🇺🇸",
                    title: "§US",
                    subtitle: "§Fahrenheit, Miles, MPH",
                    isSelected: false)
    }
    
    private var siUnitView: some View {
        makeRowView(action: { },
                    icon: "🌍",
                    title: "§International",
                    subtitle: "§Celsius, Kilometers, M/S",
                    isSelected: false)
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
    }
}

#endif
