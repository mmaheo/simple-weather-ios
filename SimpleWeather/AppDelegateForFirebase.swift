//
//  AppDelegateForFirebase.swift
//  SimpleWeather
//
//  Created by Maxime Maheo on 01/12/2020.
//

import UIKit
import Firebase

class AppDelegateForFirebase: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
