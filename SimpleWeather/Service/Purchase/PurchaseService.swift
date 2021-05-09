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

    func isPremiumMember() -> AnyPublisher<Bool, Never> {
        Deferred {
            Future { promise in
                Purchases.shared.purchaserInfo { purchaserInfo, error in
                    if purchaserInfo?.entitlements[Constant.entitlementID]?.isActive == true,
                       error == nil {
                        promise(.success(true))
                    } else {
                        promise(.success(false))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

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
    
    func purchase(package: Purchases.Package) -> AnyPublisher<Bool, Never> {
        Deferred {
            Future { promise in
                Purchases.shared.purchasePackage(package) { _, purchaserInfo, error, userCancelled in
                    if purchaserInfo?.entitlements[Constant.entitlementID]?.isActive == true,
                       !userCancelled,
                       error == nil {
                        promise(.success(true))
                    } else {
                        promise(.success(false))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
        
    }
    
    func restore() -> AnyPublisher<Bool, Never> {
        Deferred {
            Future { promise in
                Purchases.shared.restoreTransactions { purchaserInfo, error in
                    if purchaserInfo?.entitlements[Constant.entitlementID]?.isActive == true,
                       error == nil {
                        promise(.success(true))
                    } else {
                        promise(.success(false))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
