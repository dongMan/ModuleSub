//
//  CTMediator_TestA.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/5.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import CTMediator

//MARK:添加一个CTMediator的extension，注意要用public修饰，不然主项目找不到
public extension CTMediator {
    
    func A_ShowMainA_ViewController(_ _options:[AnyHashable: Any]) -> UIViewController? {
        var params = _options
        params.updateValue("MTestA", forKey: kCTMediatorParamsKeySwiftTargetModuleName)
        if let viewController = self.performTarget("TestA", action: "Swift_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    
    func A_showTargetSwift_ActionSwift(_ _options:[AnyHashable: Any],callback:@escaping (String) -> Void) -> UIViewController? {
        var params = _options
        params.updateValue(callback, forKey: "callback")
        //kCTMediatorParamsKeySwiftTargetModuleName 的value 为对应调用的组件名
        //如果Tagrget_xxx为swift类型必填，oc不用填
        params.updateValue("MTestA", forKey: kCTMediatorParamsKeySwiftTargetModuleName)
        //target内容必须是Target_xxx类中xxx的部分
        //action内容必须是Target_xxx类中Action_xxxx方法中xxxx的部分
        if let viewController = self.performTarget("TestA", action: "SwiftTest1_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }

    

    
    func A_showTargetOC_ActionOC(callback:@escaping (String) -> Void) -> UIViewController? {
        //        Swift中将闭包存入一个Dictionary或Array中是不行的。
        //        其解决方案是用 unsafeBitCast 函数将Swift闭包转为Objective-C的兼容的对象，
        //Target_xxx类为oc类型，block写法
//        用字典传递blcok在Swift无法识别
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        //会crash
        //        let params = ["callback":callback] as [AnyHashable : Any]
        if let viewController = self.performTarget("OCTestA", action: "OCTest2ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    
    func A_showTargetSwift_ActionOC(callback:@escaping (String) -> Void) -> UIViewController? {

        var params:[AnyHashable : Any] = [:]
        params.updateValue(callback, forKey: "callback")

        params.updateValue("MTestA", forKey: kCTMediatorParamsKeySwiftTargetModuleName)
        if let viewController = self.performTarget("TestA", action: "OCTest1_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    
    func A_showTargetOC_ActionSwift(callback:@escaping (String) -> Void) -> UIViewController? {
        //Target_xxx类为oc类型，block写法
        let callbackBlock = callback as @convention(block) (String) -> Void
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        //会crash
        //            let params = ["callback":callback] as [AnyHashable : Any]
        if let viewController = self.performTarget("OCTestA", action: "SwiftTest2ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
