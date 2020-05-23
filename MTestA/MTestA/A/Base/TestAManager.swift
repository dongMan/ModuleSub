//
//  TestAManager.swift
//  Pods
//
//  Created by 董雪娇 on 2020/3/24.
//

import UIKit
import MBasis

@objcMembers
public class TestAManager: NSObject {

    public static let shared = TestAManager()
    
    public func testA_Application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MGJ_TestA.initializeMethod()
        return true
    }
    
    public func testA_Application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    public func testA_Application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }
    
    public func testA_ApplicationWillEnterForeground(_ application: UIApplication) {
        print("TestADelegate.......applicationWillEnterForeground")
    }
    
    public func testA_ApplicationDidEnterBackground(_ application: UIApplication) {
        print("TestADelegate.......applicationDidEnterBackground")
    }
    
    public func testA_ApplicationDidBecomeActive(_ application: UIApplication) {
        print("TestADelegate.......applicationDidBecomeActive")
    }
    
    public func testA_ApplicationWillResignActive(_ application: UIApplication) {
        print("TestADelegate.......applicationWillResignActive")
    }
    
}
