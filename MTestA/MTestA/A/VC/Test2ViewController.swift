//
//  Test2ViewController.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/3.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis
@objc class Test2ViewController: BaseLandscapeController {
    
    typealias callBack = (String)->()
    
    @objc var test2Block:callBack? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.navigationItem.title = NSStringFromClass(self.classForCoder);

        let btn = UIButton(type: UIButton.ButtonType.custom)
        //bundle方式加载图片
        let img = UIImage(testANamed: "icon_play_more")
        btn.setBackgroundImage(img, for: .normal)
        btn.setTitle("Test2ViewController", for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(dismissed), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func dismissed(){
        test2Block?(NSStringFromClass(self.classForCoder))
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
