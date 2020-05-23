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

open class MGJ_TestC: NSObject {
     open class func initializeMethod(){
        MGJRouter.registerURLPattern(URLObjectTestC, toObjectHandler: ObjectHandle())

    }
    
    fileprivate class func ObjectHandle() -> MGJRouterObjectHandler {
        let handler = { (parameter:[AnyHashable : Any]?) -> UIViewController? in
            let aViewController = TestCMainViewController()
            aViewController.title = "TestCdemo-MGJ"
            return aViewController
        }
        return handler
    }

    
}
