//
//  RatingService.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 29/11/2020.
//

import Injectable
import Foundation
import StoreKit

final class RatingService: Injectable {
    
    // MARK: - Properties
    
    private let requestReviewEveryDays = 30
    
    private weak var userDefaultService: UserDefaultsService?
    private weak var analyticsService: AnalyticsService?

    // MARK: - Lifecycle
    
    init(userDefaultService: UserDefaultsService,
         analyticsService: AnalyticsService) {
        self.userDefaultService = userDefaultService
        self.analyticsService = analyticsService
    }
    
    // MARK: - Methods
    
    func requestReview(force: Bool = false) {
        if force || shouldReview() {
            requestReview()
        }
    }
    
    // MARK: - Private Methods
    
    private func shouldReview() -> Bool {
        guard
            let lastRatingDate = userDefaultService?.fetchLastDateRating()
        else {
            let now = Date().timeIntervalSince1970
            let nbDays = Double(requestReviewEveryDays / 2)
            let timeIntervalSince1970 = now - nbDays * 24 * 60 * 60
            
            userDefaultService?.save(lastDateRating: Date(timeIntervalSince1970: timeIntervalSince1970))
            
            return false
        }
        
        return daysSince(lastRatingDate: lastRatingDate) >= requestReviewEveryDays
    }
    
    private func requestReview() {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.currentScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
        
        analyticsService?.logEvent(event: AppAnalyticsEvent.rateTheApp)
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
