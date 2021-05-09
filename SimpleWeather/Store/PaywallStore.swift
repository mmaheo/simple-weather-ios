//
//  PaywallStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import Foundation
import Injectable
import Purchases
import Combine

final class PaywallStore: ObservableObject {
        
    // MARK: - Properties
    
    @Published private(set) var availablePackage: Purchases.Package?
    
    @Inject private var purchaseService: PurchaseService
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    
    init() {
        fetchAvailablePackages()
    }
    
    // MARK: - Methods
    
    private func fetchAvailablePackages() {
        purchaseService
            .fetchAvailablePackage()
            .receive(on: DispatchQueue.main)
            .assign(to: \.availablePackage, on: self)
            .store(in: &cancellables)
    }
}

#if DEBUG

let paywallStorePreview = PaywallStore()

#endif
