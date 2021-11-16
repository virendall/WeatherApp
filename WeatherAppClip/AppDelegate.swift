//
//  AppDelegate.swift
//  WeatherAppClip
//
//  Created by Virender Dall on 15/11/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(launchOptions?[UIApplication.LaunchOptionsKey.url])
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        print(options)
        return true
    }

    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        print(userActivity?.activityType)
        print(userActivity?.webpageURL)
        return true
    }
}

