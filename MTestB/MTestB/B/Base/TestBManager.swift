//
//  TestBManager.swift
//  TestB
//
//  Created by 董雪娇 on 2020/3/24.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis

public class TestBManager: NSObject {
    public static let shared = TestBManager()
    
    public func testB_Application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MGJ_TestB.initializeMethod()
        return true
    }
    
    public func testB_Application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    public func testB_Application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }
    
    public func testB_ApplicationWillEnterForeground(_ application: UIApplication) {
        print("TestBDelegate.......applicationWillEnterForeground")
    }
    
    public func testB_ApplicationDidEnterBackground(_ application: UIApplication) {
        print("TestBDelegate.......applicationDidEnterBackground")
    }
    
    public func testB_ApplicationDidBecomeActive(_ application: UIApplication) {
        print("TestBDelegate.......applicationDidBecomeActive")
    }
    
    public func testB_ApplicationWillResignActive(_ application: UIApplication) {
        print("TestBDelegate.......applicationWillResignActive")
    }
}
