//
//  AppDelegate.swift
//  Tomato (Pomodoro)
//
//  Created by Abdusamad Mamasoliyev on 29/04/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        window = UIWindow()
        let vc = FinishVC()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

  


}

