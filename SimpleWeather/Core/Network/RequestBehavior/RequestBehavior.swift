//
//  RequestBehavior.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 26/11/2020.
//

import Foundation

protocol RequestBehavior {
    func addQueryParameters(to request: inout URLRequest) throws
}
