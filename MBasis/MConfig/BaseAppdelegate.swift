//
//  BaseAppdelegate.swift
//  MBasis
//
//  Created by 董雪娇 on 2020/3/24.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
//open与public区别：public在只能限制在定义所在模块内部进行继承与方法的重写，而open则是只要模块有被import，在可在此模块中继承或者重写被import进来的模块中的类或方法。
//@UIApplicationMain
open class BaseAppdelegate: UIResponder, UIApplicationDelegate {
    open var window: UIWindow?
    open var justLandScape = false
    
    open func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if justLandScape {
            return .landscape
        }else {
            return .portrait
        }
    }
    
    open func setOrientation(_ fullscreen:Bool) {
        if fullscreen {
            let orientationUnknown = UIInterfaceOrientation.unknown.rawValue
            UIDevice.current.setValue(orientationUnknown, forKey: "orientation")
            
            let orientationTarget = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }else {
            let orientationUnknown = UIInterfaceOrientation.unknown.rawValue
            UIDevice.current.setValue(orientationUnknown, forKey: "orientation")
            
            let orientationTarget = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
}

