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
import PKHUD

enum PaywallStoreAction {
    case purchaseButtonTapped(package: Purchases.Package),
         restoreButtonTapped
}

final class PaywallStore: ObservableObject {
        
    // MARK: - Properties
    
    @Published private(set) var availablePackage: Purchases.Package?
    
    @Inject private var purchaseService: PurchaseService
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    
    init() { fetchAvailablePackages() }
    
    // MARK: - Methods
    
    func dispatch(action: PaywallStoreAction) {
        switch action {
        case let .purchaseButtonTapped(package): return purchaseButtonTappedAction(package: package)
        case .restoreButtonTapped: return restoreButtonTappedAction()
        }
    }
    
    // MARK: - Private Methods
    
    private func purchaseButtonTappedAction(package: Purchases.Package) {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
        
        purchaseService
            .purchase(package: package)
            .receive(on: DispatchQueue.main)
            .sink { granted in
                DispatchQueue.main.async {
                    HUD.flash(granted ? .success : .error, delay: 1)
                }
            }
            .store(in: &cancellables)
    }
    
    private func restoreButtonTappedAction() {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
        
        purchaseService
            .restore()
            .receive(on: DispatchQueue.main)
            .sink { granted in
                DispatchQueue.main.async {
                    HUD.flash(granted ? .success : .error, delay: 1)
                }
            }
            .store(in: &cancellables)
    }
    
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
