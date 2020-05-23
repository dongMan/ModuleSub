//
//  ViewController.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis
import MGJRouter

class TestAMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        let name = ["swift->swift->swift","swift->swift->oc","swift->oc->oc","swift->oc->swift","mgj"]
        for (i,str) in name.enumerated() {
            let btn = addBtn(str)
            btn.frame = CGRect(x: 50, y: 100+100*i, width: 300, height: 50)
            if i == 0 {
                btn.addTarget(self, action: #selector(push1), for: .touchUpInside)
            }else if i == 1 {
                btn.addTarget(self, action: #selector(push2), for: .touchUpInside)
            }else if i == 2 {
                btn.addTarget(self, action: #selector(push3), for: .touchUpInside)
            }else if i == 3 {
                btn.addTarget(self, action: #selector(push4), for: .touchUpInside)
            }else if i == 4 {
                btn.addTarget(self, action: #selector(mgj1), for: .touchUpInside)
            }
        }
        
    }
    
    func addBtn(_ name:String) -> UIButton {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle(name, for: .normal)
        btn.backgroundColor = .red
        view.addSubview(btn)
        return btn
    }
    
    @objc func push1(){
        // Swift -> Extension -> Swift
        let controller1 = CTMediator.sharedInstance().A_showTargetSwift_ActionSwift(["title":"Test2VC","vcName":"Test2"]) { (result) in
            //callback回调
            self.noticeOnlyText("A_showTargetSwift_ActionSwift:" + result)
        }
        guard let c1 = controller1 else {
            return
        }
        navigationController?.pushViewController(c1, animated: true)
    }
    
    @objc func push2(){
        // Swift -> Extension -> oc
        let controller = CTMediator.sharedInstance().A_showTargetSwift_ActionOC { (result) in
            //callback回调
            self.noticeOnlyText("A_showTargetSwift_ActionOC:" + result)
        }
        guard let c = controller else {
            return
        }
        navigationController?.pushViewController(c, animated: true)
    }
    
    @objc func push3(){
        // Swift -> Extension -> Swift
        let controller = CTMediator.sharedInstance().A_showTargetOC_ActionOC { (result) in
            //callback回调
            self.noticeOnlyText("A_showTargetOC_ActionOC:" + result)

        }
        guard let c = controller else {
            return
        }
        navigationController?.pushViewController(c, animated: true)
    }
    
    @objc func push4(){
        // Swift -> Extension -> Swift
        let controller = CTMediator.sharedInstance().A_showTargetOC_ActionSwift { (result) in
            //callback回调
            self.noticeOnlyText("A_showTargetOC_ActionSwift:" + result)
        }
        guard let c = controller else {
            return
        }
        navigationController?.pushViewController(c, animated: true)
    }
    
    @objc func mgj1(){
        MGJRouter.openURL(URLWITHTestA, withUserInfo: ["title":"Test2VC","vcName":"OC2","nav":navigationController]) { (name) in
            print(name)
        }
        
    }
    
}

