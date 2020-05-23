//
//  ViewController.swift
//  TestB
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis
import MGJRouter

class TestBMainViewController: UIViewController {

    typealias callBack = (String)->()
    
    @objc var testB_Block:callBack? = nil
    
    @objc var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.navigationItem.title = NSStringFromClass(self.classForCoder);
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("target-action:push->模块A首页", for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(pushClick), for: .touchUpInside)
        view.addSubview(btn)
        
        let btn1 = UIButton(type: UIButton.ButtonType.custom)
        btn1.setTitle("mgj:push->模块A首页", for: .normal)
        btn1.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        btn1.backgroundColor = .red
        btn1.addTarget(self, action: #selector(pushClick1), for: .touchUpInside)
        view.addSubview(btn1)
        
        let close = UIButton(type: UIButton.ButtonType.custom)
        close.setTitle("click close", for: .normal)
        close.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
        close.backgroundColor = .red
        close.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        view.addSubview(close)
        
    }
    
    @objc func closeClick(){
        testB_Block?(NSStringFromClass(self.classForCoder))
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushClick(){
        if let vc = CTMediator.sharedInstance().A_ShowMainA_ViewController([:]) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func pushClick1(){
        if let vc = MGJRouter.object(forURL: URLObjectTestA) as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }

}

