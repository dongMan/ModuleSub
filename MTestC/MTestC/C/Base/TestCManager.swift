//
//  TestCManager.swift
//  TestC
//
//  Created by 董雪娇 on 2020/3/24.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis

public class TestCManager: NSObject {
    public static let shared = TestCManager()
    
    public func testC_Application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MGJ_TestC.initializeMethod()
        return true
    }
    
    public func testC_Application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    public func testC_Application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    public func testC_ApplicationWillEnterForeground(_ application: UIApplication) {
        print("TestCDelegate.......applicationWillEnterForeground")
    }
    
    public func testC_ApplicationDidEnterBackground(_ application: UIApplication) {
        print("TestCDelegate.......applicationDidEnterBackground")
    }
    
    public func testC_ApplicationDidBecomeActive(_ application: UIApplication) {
        print("TestCDelegate.......applicationDidBecomeActive")
    }
    
    public func testC_ApplicationWillResignActive(_ application: UIApplication) {
        print("TestCDelegate.......applicationWillResignActive")
    }
}
