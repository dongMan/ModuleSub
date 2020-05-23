//
//  TestCDetailViewController.swift
//  TestC
//
//  Created by 董雪娇 on 2020/3/7.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit
import MBasis
import MGJRouter

class TestCDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "testc_detail"
        self.view.backgroundColor = .white
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("target_Action:push->模块B首页", for: .normal)
        btn.frame = CGRect(x: 50, y: 100, width: 300, height: 50)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(pushClick), for: .touchUpInside)
        view.addSubview(btn)
        
        let bt1 = UIButton(type: UIButton.ButtonType.custom)
        bt1.setTitle("mgj:push->模块B首页", for: .normal)
        bt1.frame = CGRect(x: 50, y: 200, width: 300, height: 50)
        bt1.backgroundColor = .red
        bt1.addTarget(self, action: #selector(pushClick1), for: .touchUpInside)
        view.addSubview(bt1)
        
        let btn2 = UIButton(type: UIButton.ButtonType.custom)
        btn2.setTitle("dismiss->返回上一层模块", for: .normal)
        btn2.frame = CGRect(x: 50, y: 300, width: 300, height: 50)
        btn2.backgroundColor = .red
        btn2.addTarget(self, action: #selector(disClicked), for: .touchUpInside)
        view.addSubview(btn2)
    }
    @objc func pushClick(){
        let controller = CTMediator.sharedInstance().A_ShowMainB_ViewController([:]) { (result) in
            self.noticeOnlyText("A_ShowMainB_ViewController:" + result)
        }
        
        guard let c = controller else {
            return
        }
        
        self.navigationController?.pushViewController(c, animated: true)

    }
    
    @objc func pushClick1(){
        MGJRouter.openURL(URLWITHTestB, withUserInfo: ["title":"titleB","nav":self.navigationController]) { (block) in
            print(block)
        }
    }
    
    @objc func disClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate var _window : UIWindow?

    static func show(vc: TestCDetailViewController) {
        let _window : UIWindow = UIWindow()
        _window.frame = UIScreen.main.bounds
        _window.windowLevel = UIWindow.Level.normal
        _window.rootViewController = UIViewController()
        _window.backgroundColor = UIColor.clear
        _window.makeKeyAndVisible()
        
        let _v = UIView.init(frame: _window.frame)
        _v.backgroundColor = .clear
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        _window.rootViewController?.present(nav, animated: false, completion: {
            vc.push(_window, hideView: _v)
            vc.view.superview?.insertSubview(_v, at: 0)
        })
    }
    
    func push(_ window : UIWindow, hideView: UIView?) {

        _window = window

    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
