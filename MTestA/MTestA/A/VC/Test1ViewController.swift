//
//  Test1ViewController.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit

class Test1ViewController: UIViewController {
    
    typealias callBack = (String)->()
    
    @objc var test1Block:callBack? = nil
    
    var name:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.navigationItem.title = NSStringFromClass(self.classForCoder);

        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Test1ViewController", for: .normal)
        
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(push), for: .touchUpInside)
        view.addSubview(btn)
        
        // Do any additional setup after loading the view.
    }
    @objc func push(){
        test1Block?(NSStringFromClass(self.classForCoder))
    }
    
    
    
}
