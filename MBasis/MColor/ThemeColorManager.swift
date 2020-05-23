//
//  ThemeColorManager.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 7/4/19.
//  Copyright © 2019 ydkt-company. All rights reserved.
//

import UIKit

/**
 * 颜色状态枚举值 颜色的定义(一个代表一套)
 */
public enum SKIN_TYPE: String {
    case blue
    case red
    case orange
    case green
}

@objcMembers
public class ThemeColorManager: NSObject {
    
    public static let shared : ThemeColorManager = {
        return ThemeColorManager()
    }()
    
    // 顶部导航是否换行 0 不换号 1 换行
    public var wrapFlag: Bool = false
    
    // 0代表彩色  1代表黑白
    public var navSkinType: Int = 0
    
    // 主要用来oc类中显示
    public var ocMainColorShared: UIColor = color_main
    
    //获取部分主题色图片用到了此字段
    public var mainSkinType: SKIN_TYPE = .blue
    
    // 接口中返回的主题颜色字段 暂时未用到
    public var themeColor: String = ""
}
