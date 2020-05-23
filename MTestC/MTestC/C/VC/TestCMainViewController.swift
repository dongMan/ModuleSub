//
//  ViewController.swift
//  TestC
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
class TestCMainViewController: UIViewController {
    
    @objc var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.navigationItem.title = NSStringFromClass(self.classForCoder);
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("click push", for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(pushClick), for: .touchUpInside)
        view.addSubview(btn)
        
        let close = UIButton(type: UIButton.ButtonType.custom)
        close.setTitle("click close", for: .normal)
        close.frame = CGRect(x: 100, y: 300, width: 200, height: 100)
        close.backgroundColor = .red
        close.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        view.addSubview(close)
        
    }
    
    @objc func closeClick(){
        print("clicked...")

        
        self.navigationController?.popViewController(animated: true)
    }
    

    @objc func pushClick(){
        TestCDetailViewController.show(vc: TestCDetailViewController())
        
    }
    
}

