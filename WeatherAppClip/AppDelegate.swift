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
        guard let launchOptions = launchOptions, let dic = launchOptions[UIApplication.LaunchOptionsKey.userActivityDictionary] as? [AnyHashable: Any] else {
            return true
        }
        print(dic)
        guard let activity = dic["UIApplicationLaunchOptionsUserActivityKey"] as? NSUserActivity else {
            return true
        }
        print(activity.webpageURL?.absoluteString)
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        print(options)
        return true
    }
}

