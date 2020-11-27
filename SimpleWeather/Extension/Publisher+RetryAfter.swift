//
//  Publisher+RetryAfter.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 27/11/2020.
//

import Combine
import Foundation

extension Publisher {
    func retry<Output, Failure>(max nbRetry: Int,
                                interval: DispatchTimeInterval)
        -> Publishers.Catch<Self, AnyPublisher<Output, Failure>> where Output == Self.Output, Failure == Self.Failure {
        self.catch { _ in
            Publishers
                .Delay(upstream: self,
                       interval: DispatchQueue.SchedulerTimeType.Stride(interval),
                       tolerance: 1,
                       scheduler: DispatchQueue.global())
                .retry(nbRetry)
                .eraseToAnyPublisher()
        }
    }
}
