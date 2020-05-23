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

open class MGJ_TestB: NSObject {
     class open func initializeMethod(){
        MGJRouter.registerURLPattern(URLObjectTestB, toObjectHandler: ObjectHandle())
        
        MGJRouter.registerURLPattern(URLWITHTestB, toHandler: Indexhandler())

    }
    
    fileprivate class func ObjectHandle() -> MGJRouterObjectHandler {
        let handler = { (parameter:[AnyHashable : Any]?) -> UIViewController? in
            let aViewController = TestBMainViewController()
            aViewController.title = "TestbBdemo-MGJ"
            aViewController.testB_Block = {(name:String) -> Void in
                //***extension里创建block类型的存储属性***
                //***CTMediator扩展类如果跟Target_XXX类  不相同，获取callback回调***
                if let block = parameter?[MGJRouterParameterCompletion] {
                    typealias CallbackType = @convention(block) (String) -> Void
                    let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                    let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                    callback("TestB...callback:"+name)
                }
            }
            return aViewController
        }
        return handler
    }
    
    fileprivate class func Indexhandler() -> MGJRouterHandler {
        let handler = { (parameter:[AnyHashable : Any]?) in
            
            if let userInfo = parameter?[MGJRouterParameterUserInfo] as? [AnyHashable:Any] {
                let title = userInfo["title"] as? String
                let nav = userInfo["nav"] as? UINavigationController

                let aViewController = TestBDetailViewController()
                aViewController.title = title
                aViewController.testBDetailBlock = {(name:String) -> Void in
                    //***extension里创建block类型的存储属性***
                    //***CTMediator扩展类如果跟Target_XXX类  不相同，获取callback回调***
                    if let block = parameter?[MGJRouterParameterCompletion] {
                        typealias CallbackType = @convention(block) (String) -> Void
                        let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                        let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                        callback("testBDetailBlock...callback:"+name)
                    }
                }
                nav?.pushViewController(aViewController, animated: true)
            }
        }
        return handler
    }
}
