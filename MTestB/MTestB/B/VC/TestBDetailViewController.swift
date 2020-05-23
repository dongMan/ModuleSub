//
//  TestBDetailViewController.swift
//  TestB
//
//  Created by 董雪娇 on 2020/3/16.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit

class TestBDetailViewController: UIViewController {

    typealias callBack = (String)->()
    
    @objc var testBDetailBlock:callBack? = nil
    
    @objc var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.navigationItem.title = NSStringFromClass(self.classForCoder);
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("testBDetail", for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(push), for: .touchUpInside)
        view.addSubview(btn)
        
        // Do any additional setup after loading the view.
    }
    @objc func push(){
        testBDetailBlock?(NSStringFromClass(self.classForCoder))
    }
    

}
