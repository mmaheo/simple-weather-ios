//
//  PaywallView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import SwiftUI

struct PaywallView: View {
    
    // MARK: - Properties
    
    @Binding var isShowingPaywall: Bool
    @EnvironmentObject private var paywallStore: PaywallStore
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            headerView
            titleView
            limitationView
            Spacer()
            featuresView
            Spacer()
            offerButtonsView
        }
        .padding()
        .onAppear {
            paywallStore.dispatch(action: .viewDidAppear)
        }
    }
}

extension PaywallView {
    
    private var limitationView: some View {
        Text("quota_exceeded")
            .bold()
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(.red)
    }
    
    private var offerButtonsView: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Text("start_one_month_free_trial")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            })
            .background(Color.blue)
            .cornerRadius(8)
            
            Text("price_after")
                .italic()
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    private var titleView: some View {
        VStack {
            Text("paywall_title")
                .font(.title)
                .bold()
                .padding(.bottom)
            
            Image(systemName: "sun.max.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
        }
    }
    
    private var featuresView: some View {
        VStack(alignment: .leading) {
            makeFeatureView(title: "Widgets",
                            description: "unlock_widgets")
            
            makeFeatureView(title: "unlimited_access",
                            description: "fetch_weather_when_you_want")
        }
    }
    
    private func makeFeatureView(title: LocalizedStringKey, description: LocalizedStringKey) -> some View {
        HStack {
            Image(systemName: "checkmark")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: 20)
                
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .bold()
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                isShowingPaywall = false
            }, label: {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.gray)
            })
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("restore")
            })
        }
        .padding(.bottom, 32)
    }
    
}

#if DEBUG

struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PaywallView(isShowingPaywall: .constant(true))
            
            PaywallView(isShowingPaywall: .constant(true))
                .preferredColorScheme(.dark)
            
            PaywallView(isShowingPaywall: .constant(true))
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory,
                             .accessibilityExtraExtraExtraLarge)
        }
        .environmentObject(paywallStorePreview)
    }
}

#endif
