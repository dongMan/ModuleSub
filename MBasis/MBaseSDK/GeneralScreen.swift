//
//  YXBaseConfig.swift
//  AFNetworking
//
//  Created by ydkt-author on 3/26/19.
//

import Foundation

public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds

public let __SCREEN_SCALE: CGFloat = UIScreen.main.scale
public let __SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
public let __SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
public let __SCREEN_SIZE = UIScreen.main.bounds.size
public let __SCREEN_BOUNDS = UIScreen.main.bounds

public let __SCREEN_DISPLAY: String = String(format: "%.0fx%.0f", __SCREEN_WIDTH * __SCREEN_SCALE, __SCREEN_HEIGHT * __SCREEN_SCALE)

public let __SCREEN_BOUNDS_SIZE_CHAGE = CGRect(x: 0, y: 0, width: __SCREEN_SIZE.height, height: __SCREEN_SIZE.width)

//
public let __iPhoneX = ScreenHeight >= 811
public let __StatusBarH = CGFloat(__iPhoneX ? 44:20)
public let __NavHeight = __StatusBarH+44
public let __NavH = CGFloat(__iPhoneX ? 88:64)
public let __TabBarH = CGFloat(__iPhoneX ? 83:49)
public let __TabBarMargin = CGFloat(__iPhoneX ? 34 : 0)

//
public func CGScaleXC(_ __v__ : CGFloat) -> CGFloat { return (__SCREEN_SIZE.width - ceil((__v__*(__SCREEN_SIZE.width/375.0))))*0.5 }
public func CGScaleX(_ __v__ : CGFloat) -> CGFloat { return round((__v__*(__SCREEN_SIZE.width/375.0))) }
public func CGScale(_ __v__ : CGFloat) -> CGFloat { return ceil((__v__*(__SCREEN_SIZE.width/375.0))) }
public func CGScaleSize(_ __w__ : CGFloat, _ __h__ : CGFloat) -> CGSize  { return CGSize(width: CGScale(__w__), height: CGScale(__h__)) }
public func CGScaleRect(_ __x__ : CGFloat, _ __y__ : CGFloat, _ __w__ : CGFloat, _ __h__ : CGFloat) ->CGRect { return CGRect(x: CGScale(__x__), y: CGScale(__y__), width: CGScale(__w__), height: CGScale(__h__)) }

//
public func VIEWX(_ __view : UIView) -> CGFloat { return (__view.frame.origin.x) }
public func VIEWY(_ __view : UIView) -> CGFloat { return (__view.frame.origin.y) }
public func VIEWW(_ __view : UIView) -> CGFloat { return (__view.frame.size.width) }
public func VIEWH(_ __view : UIView) -> CGFloat { return (__view.frame.size.height) }
public func VIEWMaxX(_ __view : UIView) -> CGFloat { return (__view.frame.origin.x + __view.frame.size.width) }
public func VIEWMaxY(_ __view : UIView) -> CGFloat { return (__view.frame.origin.y + __view.frame.size.height) }


public let CGRectMin = CGRect(x: 0, y: 0, width: 0, height: 0.001)
