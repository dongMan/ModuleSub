//
//  Target_TestC.swift
//  TestC
//
//  Created by 董雪娇 on 2020/3/7.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit

@objc class Target_TestC: NSObject {
    @objc func Action_Swift_ViewController(_ params:NSDictionary) -> UIViewController {
        let aViewController = TestCMainViewController()
        aViewController.title = "TestCdemo"
        return aViewController
    }
}
