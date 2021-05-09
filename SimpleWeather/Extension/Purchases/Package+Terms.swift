//
//  Package+Terms.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import Purchases

extension Purchases.Package {
    func terms(for package: Purchases.Package) -> String {
        if let intro = package.product.introductoryPrice {
            if intro.price == 0 {
                return String(format: NSLocalizedString("free_trial", comment: ""), intro.subscriptionPeriod.periodTitle)
            } else {
                return String(format: NSLocalizedString("price_for_period", comment: ""), package.localizedIntroductoryPriceString, intro.subscriptionPeriod.periodTitle)
            }
        } else {
            return NSLocalizedString("unlimited_access", comment: "")
        }
    }
}
