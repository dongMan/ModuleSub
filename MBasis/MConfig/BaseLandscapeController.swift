//
//  TestALandscapeViewController.swift
//  TestA
//
//  Created by 董雪娇 on 2020/3/24.
//  Copyright © 2020 董雪娇. All rights reserved.
//

import UIKit

open class BaseLandscapeController: UIViewController {
    
    open override func viewWillAppear(_ animated: Bool) {
        if let base = UIApplication.shared.delegate as? BaseAppdelegate{
            //横屏时禁止左拽滑出
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            //允许横屏
            base.justLandScape = true
            //强制为横屏 ， 如果是不强制横屏注视下面代码即可
            base.setOrientation(true)
        }
        super.viewWillAppear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let base = UIApplication.shared.delegate as? BaseAppdelegate{
            //竖屏时允许左拽滑出
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            //禁止横屏
            base.justLandScape = false
            //强制为竖屏
            base.setOrientation(false)
        }
        super.viewWillDisappear(animated)
    }
    
//    转自链接：https://learnku.com/articles/37144/ios-development-of-single-page-horizontal-screen-processing-swift-edition
    
}
