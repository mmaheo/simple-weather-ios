//
//  PaywallStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 09/05/2021.
//

import Foundation
import Injectable

enum PaywallStoreAction {
    case viewDidAppear
}

final class PaywallStore: ObservableObject {
        
    // MARK: - Properties
    
    @Inject private var purchaseService: PurchaseService
    
    // MARK: - Methods
    
    func dispatch(action: PaywallStoreAction) {
        switch action {
        case .viewDidAppear:
            viewDidAppearAction()
        }
    }
    
    // MARK: - Action Methods
    
    private func viewDidAppearAction() {
        purchaseService.fetchOfferings()
    }
}

#if DEBUG

let paywallStorePreview = PaywallStore()

#endif
