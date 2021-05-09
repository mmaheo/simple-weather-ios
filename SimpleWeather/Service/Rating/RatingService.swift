//
//  RatingService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import Injectable
import Foundation
import StoreKit
import Bugsnag

final class RatingService: Injectable {
    
    // MARK: - Properties
    
    private let requestReviewEveryDays = 7
    
    private weak var userDefaultService: UserDefaultsService?

    // MARK: - Lifecycle
    
    init(userDefaultService: UserDefaultsService) {
        self.userDefaultService = userDefaultService
    }
    
    // MARK: - Methods
    
    func requestReview(force: Bool = false) {
        if force || shouldReview() {
            requestReview()
        }
    }
    
    // MARK: - Private Methods
    
    private func shouldReview() -> Bool {
        guard let lastRatingDate = userDefaultService?.fetchLastDateRating() else { return true }
        
        return daysSince(lastRatingDate: lastRatingDate) >= requestReviewEveryDays
    }
    
    private func requestReview() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.currentScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
        
        userDefaultService?.save(lastDateRating: Date())
    }
    
    private func daysSince(lastRatingDate: Date) -> Int {
        let calendar = Calendar.current
        
        let lastRatingDay = calendar.startOfDay(for: lastRatingDate)
        let today = calendar.startOfDay(for: Date())
        
        guard
            let numberOfDays = calendar.dateComponents([.day],
                                                       from: lastRatingDay,
                                                       to: today)
                .day
        else { return 0 }
        
        return numberOfDays
    }
}
