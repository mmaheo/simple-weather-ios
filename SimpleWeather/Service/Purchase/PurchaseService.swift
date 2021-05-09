//
//  PurchaseService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import Injectable
import Purchases

final class PurchaseService: Injectable {
    
    // MARK: - Methods
    
    func fetchOfferings() {
        Purchases.shared.offerings { (offerings, error) in
            if let packages = offerings?.current?.availablePackages {
                print(packages)
            }
        }
    }
    
}
