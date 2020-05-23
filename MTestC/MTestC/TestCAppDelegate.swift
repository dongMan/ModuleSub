//
//  AppDelegate.swift
//  TestC
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis

@UIApplicationMain
class TestCAppDelegate: BaseAppdelegate {
//    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        _ = TestCManager.shared.testC_Application(application, willFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .red
        let nav = UINavigationController(rootViewController: TestCMainViewController())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }


    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        _ = TestCManager.shared.testC_Application(app, open: url, options: options)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        TestCManager.shared.testC_ApplicationWillEnterForeground(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        TestCManager.shared.testC_ApplicationDidEnterBackground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        TestCManager.shared.testC_ApplicationDidBecomeActive(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        TestCManager.shared.testC_ApplicationWillResignActive(application)
    }
    
}

