//
//  PurchaseService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import Injectable
import Purchases
import Combine

final class PurchaseService: Injectable {
    
    // MARK: - Methods
    
    func fetchAvailablePackage() -> AnyPublisher<Purchases.Package?, Never> {
        Deferred {
            Future { promise in
                Purchases.shared.offerings { offerings, _ in
                    guard let availablePackages = offerings?.current?.availablePackages else { return }
                    
                    promise(.success(availablePackages.first))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
