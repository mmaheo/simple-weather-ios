//
//  PaywallView.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import SwiftUI
import Purchases

struct PaywallView: View {
    
    // MARK: - Properties
    
    @Binding var isShowingPaywall: Bool
    @EnvironmentObject private var paywallStore: PaywallStore

    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                headerView
                titleView
                limitationView
                Spacer()
                featuresView
                Spacer()
                
                paywallStore.availablePackage.map { package in
                    VStack {
                        makeOfferButtonsView(package: package)
                        makeFooterView(package: package)
                    }
                }
            }
            .padding()
        }
    }
}

extension PaywallView {
    
    private func makeFooterView(package: Purchases.Package) -> some View {
        Text(String(format: NSLocalizedString("paywall_condition", comment: ""), package.localizedPriceString, package.product.subscriptionPeriod?.durationTitle ?? ""))
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.top)
    }
    
    private var limitationView: some View {
        Text(String(format: NSLocalizedString("quota_exceeded", comment: ""), Constant.quota))
            .bold()
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(.red)
    }
    
    private func makeOfferButtonsView(package: Purchases.Package) -> some View {
        Button(action: {
            paywallStore.dispatch(action: .purchaseButtonTapped(package: package))
        }, label: {
            HStack {
                VStack {
                    HStack {
                        Text(package.product.localizedTitle)
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                    }
                    HStack {
                        Text(package.terms(for: package))
                            .font(.subheadline)
                            .foregroundColor(Color.white.opacity(0.7))
                        Spacer()
                    }
                }
                .padding([.top, .bottom], 8.0)
                
                Spacer()
                
                Text(package.localizedPriceString)
                    .font(.title3)
                    .bold()
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        })
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
                paywallStore.dispatch(action: .restoreButtonTapped)
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
