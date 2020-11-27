//
//  ReachabilityMock.swift
//  SimpleWeatherTests
//
//  Created by Maxime Maheo on 27/11/2020.
//

@testable import SimpleWeather
import SystemConfiguration

final class ReachabilityMock: Reachability {
    
    // MARK: - Properties
    
    override var connection: Reachability.Connection {
        _connection
    }
    
    private var _connection: Connection
    
    // MARK: - Lifecycle
    
    init(connection: Connection) {
        self._connection = connection
        super.init(reachabilityRef: SCNetworkReachabilityCreateWithName(nil, "https://test.com")!,
                   queueQoS: .default,
                   targetQueue: nil)
    }
    
    required init(reachabilityRef: SCNetworkReachability,
                  queueQoS: DispatchQoS = .default,
                  targetQueue: DispatchQueue? = nil) {
        fatalError("init(reachabilityRef:queueQoS:targetQueue:) has not been implemented")
    }
    
    required init(reachabilityRef: SCNetworkReachability,
                  queueQoS: DispatchQoS = .default,
                  targetQueue: DispatchQueue? = nil,
                  notificationQueue: DispatchQueue? = .main) {
        fatalError("init(reachabilityRef:queueQoS:targetQueue:notificationQueue:) has not been implemented")
    }
}
