//
//  AppDelegate.swift
//  Credis
//
//  Created by Yaro on 3/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: Storyboards.Users.rawValue, bundle: nil)

        let initialViewController = storyboard.instantiateInitialViewController()

        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

        return true
    }
}

