//
//  Global.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 16/4/16.
//  Copyright © 2016年 ydkt-company. All rights reserved.
//

import Foundation

//
public func __RGBA(_ rgbValue:Int, alpha: CGFloat) ->UIColor {
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: alpha)
}

public func __RGB(_ rgbValue:Int) ->UIColor {
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: 1)
}


// MARK: - general color begin
//主题色以及导航颜色(根据模块类型可切换)
public var color_main      = color_blue
public var color_nav_bg    = color_blue
public var color_nav_title = color_white

//其他相关颜色
public let color_blue   = __RGB(0x00aaff) // 主题色中的蓝色
public let color_red    = __RGB(0xfe4343) // 主题色中的红色  价格和支付相关
public let color_orange = __RGB(0xffb033) // 主题色中的橙色
public let color_green  = __RGB(0x2cc17b) // 主题色中的绿色

public let color_white  = __RGB(0xffffff) // 白色
public let color_black  = __RGB(0x000000) // 黑色

/**
 * 用于分割线rgb(236,236,236)
 */
public let color_line = __RGB(0xececec) // 用于分割线rgb(236,236,236) __RGB(0xe0e0e0)//(224,224,224)
/**
*  常用于一级标题文字颜色rgb(42,42,42)
*/
public let color_2a2a2a = __RGB(0x2a2a2a) // 常用于一级标题文字颜色（42,42,42）
/**
 * 用于一级标题文字颜色rgb(51,51,51)
 */
public let color_333333 = __RGB(0x333333) // 一级标题文字颜色(51,51,51)
/**
 * 用于一级标题文字颜色rgb(66,66,66)
 */
public let color_424242 = __RGB(0x424242) // 一级标题文字颜色rgb(66,66,66)
/**
 * 内容等二级标题文字颜色(147,153,159)
 */
public let color_93999f = __RGB(0x93999F) // 内容等二级标题文字颜色（147,153,159）
/**
 * 三级标题文字颜色(181,185,188)
 */
public let color_b5b9bc = __RGB(0xb5b9bc) // 三级标题文字颜色(181,185,188)
/**
 * 部分view的背景色(238,238,238)
 */
public let color_eeeeee = __RGB(0xeeeeee) // 常用于部分view的背景色(238,238,238)
/**
 * 常用于view的默认浅灰背景色（246,246,246）
 */
public let color_f6f6f6 = __RGB(0xf6f6f6) // view的默认浅灰背景色（246,246,246）

/**
 * 常用于view的默认浅灰背景色（246,246,246）
 */
public let color_f8f9fa = __RGB(0xF8F9FA)

public let color_cccccc = __RGB(0xCCCCCC)
public let color_939ca5 = __RGB(0x939ca5)
public let color_efeff4 = __RGB(0xefeff4)
public let color_798189 = __RGB(0x798189)
public let color_999999 = __RGB(0x999999)
public let color_666666 = __RGB(0x666666)
public let color_969fa8 = __RGB(0x969FA8)
public let color_f2f5f7 = __RGB(0xf2f5f7)
public let color_f0f0f2 = __RGB(0xf0f0f2)
public let color_f5c481 = __RGB(0xF5C481) // 学习卡的黄色
// MARK: - general color end
