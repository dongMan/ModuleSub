//
//  Target_TestB.swift
//  TestB
//
//  Created by 董雪娇 on 2020/3/7.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit

@objc class Target_TestB: NSObject {
    
    @objc func Action_Swift_ViewController(_ params:NSDictionary) -> UIViewController {
        let aViewController = TestBMainViewController()
        aViewController.title = "TestBdemo"
        aViewController.testB_Block = {(name:String) -> Void in
            if let callback = params["callback"] as? (String) -> Void {
                callback(name)
            }
        }
        return aViewController
    }
}
