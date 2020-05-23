//
//  AppDelegate.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis

@UIApplicationMain
class TestAAppDelegate: BaseAppdelegate {

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        _ = TestAManager.shared.testA_Application(application, willFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .red
        let nav = UINavigationController(rootViewController: TestAMainViewController())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        _ = TestAManager.shared.testA_Application(app, open: url, options: options)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        TestAManager.shared.testA_ApplicationWillEnterForeground(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        TestAManager.shared.testA_ApplicationDidEnterBackground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        TestAManager.shared.testA_ApplicationDidBecomeActive(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        TestAManager.shared.testA_ApplicationWillResignActive(application)
    }
}

