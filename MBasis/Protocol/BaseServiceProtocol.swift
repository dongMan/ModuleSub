//
//  BaseServiceProtocol.swift
//  Pods
//
//  Created by 董雪娇 on 2020/4/17.
//

import Foundation

@objc public protocol BaseServiceProtocol {
    // protocol中的约定方法，当方法中有参数时是不能有默认值的
    func Modeul_Application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]) -> Bool
    
    func Modeul_Application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    
    
    
    @objc optional func Modeul_Application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
    
    @objc optional func Modeul_ApplicationWillEnterForeground(_ application: UIApplication)
    
    @objc optional func Modeul_ApplicationDidEnterBackground(_ application: UIApplication)
    
    @objc optional func Modeul_ApplicationDidBecomeActive(_ application: UIApplication)
    
    @objc optional func Modeul_ApplicationWillResignActive(_ application: UIApplication)
    
}
