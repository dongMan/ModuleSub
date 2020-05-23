//
//  CTMediator+ModuleC.swift
//  Pods
//
//  Created by 董雪娇 on 2020/3/7.
//

import UIKit


//MARK:添加一个CTMediator的extension，注意要用public修饰，不然主项目找不到
public extension CTMediator {
    
    func A_ShowMainC_ViewController(_ _options:[AnyHashable: Any]) -> UIViewController? {
        var params = _options
        params.updateValue("MTestC", forKey: kCTMediatorParamsKeySwiftTargetModuleName)
        if let viewController = self.performTarget("TestC", action: "Swift_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
