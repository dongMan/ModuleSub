//
//  MGJ_TestA.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/16.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis
import MGJRouter

open class MGJ_TestA: NSObject {
     open class func initializeMethod(){
        MGJRouter.registerURLPattern(URLObjectTestA, toObjectHandler: ObjectHandle())
        
        MGJRouter.registerURLPattern(URLWITHTestA, toHandler: Indexhandler())
    }
    
    fileprivate class func ObjectHandle() -> MGJRouterObjectHandler {
        let handler = { (parameter:[AnyHashable : Any]?) -> UIViewController? in
            let aViewController = TestAMainViewController()
            aViewController.title = "TestAdemo"
            return aViewController
        }
        return handler
    }

    fileprivate class func Indexhandler() -> MGJRouterHandler {
        let handler = { (parameter:[AnyHashable : Any]?) in
            
            if let userInfo = parameter?[MGJRouterParameterUserInfo] as? [AnyHashable:Any] {
                let title = userInfo["title"] as? String
                let vcName = userInfo["vcName"] as? String
                let nav = userInfo["nav"] as? UINavigationController

                if vcName == "Test2" {
                    let aViewController = Test2ViewController()
                    aViewController.title = title
                    aViewController.test2Block = {(name:String) -> Void in
                        //***extension里创建block类型的存储属性***
                        //***CTMediator扩展类如果跟Target_XXX类  不相同，获取callback回调***
                        if let block = parameter?[MGJRouterParameterCompletion] {
                            typealias CallbackType = @convention(block) (String) -> Void
                            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                            let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                            callback("Test2ViewController...callback:"+name)
                        }
                    }
                    nav?.pushViewController(aViewController, animated: true)
                }else if vcName == "OC2" {
                    let aViewController = TestOC2ViewController()
                    aViewController.title = title
                    aViewController.test2CompleteHandler = {(name:String) -> Void in
                        //***extension里创建block类型的存储属性***
                        //***CTMediator扩展类如果跟Target_XXX类  不相同，获取callback回调***
                        if let block = parameter?[MGJRouterParameterCompletion] {
                            typealias CallbackType = @convention(block) (String) -> Void
                            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                            let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                            callback("TestOC2ViewController...callback:"+name)
                        }
                    }
                    nav?.pushViewController(aViewController, animated: true)
                }
            }
        }
        return handler
    }
    
}
