//
//  Target_TestA.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/5.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
//Target_xxx格式
@objc class Target_TestA: NSObject {
    //因为是swift文件，必须添加@objc
    //Action_xxxx格式
    @objc func Action_Swift_ViewController(_ params:NSDictionary) -> UIViewController {
        let aViewController = TestAMainViewController()
        aViewController.title = "TestAdemo"
        return aViewController
    }
    
    @objc func Action_SwiftTest1_ViewController(_ params:NSDictionary) -> UIViewController? {
        let title = params["title"] as? String
        let vcName = params["vcName"] as? String
        if vcName == "Test1" {
            let aViewController = Test1ViewController()
            aViewController.title = title
            aViewController.test1Block = {(name:String) -> Void in
                //CTMediator扩展类如果跟Target_XXX类  相同  ，获取callback回调
                if let callback = params["callback"] as? (String) -> Void {
                    callback("swift:"+name)
                    return;
                }
                //***extension里创建block类型的存储属性***
                //***CTMediator扩展类如果跟Target_XXX类  不相同，获取callback回调***
                if let block = params["callback"] {
                    typealias CallbackType = @convention(block) (String) -> Void
                    let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                    let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                    callback("oc:"+name)
                    return;
                }
            }
            return aViewController
        }else if vcName == "Test2" {
            let aViewController = Test2ViewController()
            aViewController.title = title
            aViewController.test2Block = {(name:String) -> Void in
                if let callback = params["callback"] as? (String) -> Void {
                    callback("swift:"+name)
                    return;
                }
                if let block = params["callback"] {
                    typealias CallbackType = @convention(block) (String) -> Void
                    let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                    let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                    callback("oc:"+name)
                    return;
                }
            }
            return aViewController
        }else {
            print("没有传vcNmae。。。")
            return nil
        }
    }
    
    @objc func Action_OCTest2_ViewController(_ params:NSDictionary) -> UIViewController {
        let aViewController = TestOC2ViewController()
        aViewController.test2CompleteHandler = {(name:String) -> Void in
//            CTMediator扩展类如果跟Target_XXX类  相同  ，获取callback回调
            if let callback = params["callback"] as? (String) -> Void {
                callback("swift:"+name)
                return;
            }
//            ***extension里创建block类型的存储属性
//            ***CTMediator扩展类如果跟Target_XXX类  不相同，获取callback回调
            if let block = params["callback"] {
                typealias CallbackType = @convention(block) (String) -> Void
                let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
                let callback = unsafeBitCast(blockPtr, to: CallbackType.self)
                callback("oc:"+name)
                return;
            }
        }
        return aViewController
    }
    
    @objc func Action_OCTest1_ViewController(_ params:NSDictionary) -> UIViewController {
        let aViewController = TestOC1ViewController()
        aViewController.testCompleteHandler = {(name:String) -> Void in
            if let callback = params["callback"] as? (String) -> Void {
                callback(name)
            }
        }
        return aViewController
    }
}
