//
//  AppDelegate.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-19.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let resumeViewController = ResumeTableViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: resumeViewController)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }

}

