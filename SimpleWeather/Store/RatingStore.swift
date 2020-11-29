//
//  RatingStore.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import Foundation
import Injectable

enum RatingStoreAction {
    case requestReview(force: Bool)
}

final class RatingStore: ObservableObject {
    
    // MARK: - Properties
    
    @Inject private var ratingService: RatingService
    
    // MARK: - Methods
    
    func dispatch(action: RatingStoreAction) {
        switch action {
        case let .requestReview(force):
            requestReviewAction(force: force)
        }
    }
    
    // MARK: - Action Methods
    
    private func requestReviewAction(force: Bool) {
        ratingService.requestReview(force: force)
    }
}

#if DEBUG

let ratingStorePreview = RatingStore()

#endif
