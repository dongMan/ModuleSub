//
//  SwiftNotice.swift
//  SwiftNotice
//
//  Created by JohnLui on 15/4/15.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//https://github.com/johnlui/SwiftNotice

import Foundation
import UIKit
import FFToast
import MBProgressHUD

extension NSObject {
    @objc open func showNoticeText(showText:String, showY:Float = -50, dealyTime:Float = 3){
        if let win = UIApplication.shared.delegate?.window as? UIWindow {
            let hud = MBProgressHUD.showAdded(to: win, animated: true)
            hud.isUserInteractionEnabled = false
            hud.mode = .text
            hud.offset = CGPoint(x: 0, y: Int(showY))
            hud.margin = 10
            hud.bezelView.backgroundColor = color_black
            hud.label.textColor = .white
            hud.label.text = showText
            hud.hide(animated: true, afterDelay: TimeInterval(dealyTime))
        }
    }
}


extension UIViewController {
    
    
    /// wait with your own animated images
    func pleaseWaitWithImages(_ imageNames: Array<UIImage>, timeInterval: Int) {
        SwiftNotice.wait(imageNames, timeInterval: timeInterval)
    }
    // api changed from v3.3
    func noticeTop(_ text: String, autoClear: Bool = true, autoClearTime: Int = 1) {
        SwiftNotice.noticeOnStatusBar(text, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    
    // new apis from v3.3
    func noticeSuccess(_ text: String, autoClear: Bool = false, autoClearTime: Int = 3) {
        SwiftNotice.showNoticeWithText(NoticeType.success, text: text, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    func noticeError(_ text: String, autoClear: Bool = false, autoClearTime: Int = 3) {
        SwiftNotice.showNoticeWithText(NoticeType.error, text: text, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    func noticeInfo(_ text: String, autoClear: Bool = false, autoClearTime: Int = 3) {
        SwiftNotice.showNoticeWithText(NoticeType.info, text: text, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    
    // old apis
    func successNotice(_ text: String, autoClear: Bool = true) {
        SwiftNotice.showNoticeWithText(NoticeType.success, text: text, autoClear: autoClear, autoClearTime: 3)
    }
    func errorNotice(_ text: String, autoClear: Bool = true) {
        SwiftNotice.showNoticeWithText(NoticeType.error, text: text, autoClear: autoClear, autoClearTime: 3)
    }
    func infoNotice(_ text: String, autoClear: Bool = true) {
        SwiftNotice.showNoticeWithText(NoticeType.info, text: text, autoClear: autoClear, autoClearTime: 3)
    }
    func notice(_ text: String, type: NoticeType, autoClear: Bool, autoClearTime: Int = 3) {
        SwiftNotice.showNoticeWithText(type, text: text, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    
    /// wait with your own animated images
    @objc static public func pleaseWaitWithText(_ msg: String) {
        SwiftNotice.waitWithText(msg)
    }
    @objc open func pleaseWaitWithText(_ msg: String) {
        SwiftNotice.waitWithText(msg)
    }
    @objc static public func pleaseWait() {
        SwiftNotice.clear()
        SwiftNotice.wait()
    }
    
    @objc open func pleaseWait() {
        SwiftNotice.clear()
        SwiftNotice.wait()
    }
    @objc open func noticeOnlyText(_ text: String, autoClear: Bool = true, autoClearTime: Int = 3) {
        SwiftNotice.clear()
//        SwiftNotice.showText(text,autoClear: autoClear, autoClearTime: autoClearTime)
        
        let toast = FFToast.init(toastWithTitle: nil, message: text, iconImage: nil)
        toast?.duration = 2.0
        toast?.toastCornerRadius = 4
        toast?.toastType = .default
        toast?.toastPosition = .bottom
        toast?.show()
    }
    
    @objc static public func clearAllNotice() {
        SwiftNotice.clear()
    }
    
    @objc open func clearAllNotice() {
        SwiftNotice.clear()
    }
    

    
}

enum NoticeType{
    case success
    case error
    case info
}

class SwiftNotice: NSObject {
    
    static var windows = Array<UIWindow?>()
    static let rv = UIApplication.shared.keyWindow?.subviews.first as UIView?
    static var timer: DispatchSource? = nil
    static var timerTimes = 0
    static var degree: Double {
        get {
            let d = [0, 0, 180, 270, 90][UIApplication.shared.statusBarOrientation.rawValue] as Double
            return d
        }
    }
    static var center: CGPoint {
        get {
            var array = [UIScreen.main.bounds.width, UIScreen.main.bounds.height]
            array = array.sorted(by: <)
            let screenWidth = array[0]
            let screenHeight = array[1]
            let x = [0, screenWidth/2, screenWidth/2, 10, screenWidth-10][UIApplication.shared.statusBarOrientation.hashValue] as CGFloat
            let y = [0, 10, screenHeight-10, screenHeight/2, screenHeight/2][UIApplication.shared.statusBarOrientation.hashValue] as CGFloat
            return CGPoint(x: x, y: y)
        }
    }
    
    // fix https://github.com/johnlui/SwiftNotice/issues/2
    // thanks broccolii(https://github.com/broccolii) and his PR https://github.com/johnlui/SwiftNotice/pull/5
    @objc static public func clear() {
        self.cancelPreviousPerformRequests(withTarget: self)
        if let _ = timer {
            timer?.cancel()
            timer = nil
            timerTimes = 0
        }
        for  window  in windows
        {
            if(window == nil)
            {
                break;
            }
            window?.rootViewController=nil
            if(window?.subviews == nil)
            {
                continue
            }
            for sub in (window?.subviews)!
            {
                sub.removeFromSuperview()
            }
        }
        windows.removeAll(keepingCapacity: false)
    }
    
    static func noticeOnStatusBar(_ text: String, autoClear: Bool, autoClearTime: Int) {
        let frame = UIApplication.shared.statusBarFrame
        let window = UIWindow()
        window.rootViewController=UIViewController.init(nibName: nil, bundle: nil)
        window.rootViewController?.view.backgroundColor=UIColor.clear
        window.backgroundColor = UIColor.clear
        let view = UIView()
        view.backgroundColor = UIColor(red: 0x6a/0x100, green: 0xb4/0x100, blue: 0x9f/0x100, alpha: 1)
        
        let label = UILabel(frame: frame)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = text
        view.addSubview(label)
        
        window.frame = UIScreen.main.bounds
        view.frame = frame
        
        window.windowLevel = UIWindow.Level.statusBar
        window.isHidden = false
        // change orientation
        window.center = center
        window.transform = CGAffineTransform(rotationAngle: CGFloat(degree * Double.pi / 180))
        window.addSubview(view)
        windows.append(window)
        if autoClear {
            let selector = #selector(SwiftNotice.hideNotice(_:))
            self.perform(selector, with: window, afterDelay: TimeInterval(autoClearTime))
        }
    }
    
    @objc static public func waitWithText(_ msg: String = "加载中") {
        let frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        let window = UIWindow()
        window.rootViewController=UIViewController.init(nibName: nil, bundle: nil)
        window.rootViewController?.view.backgroundColor=UIColor.clear
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        ai.frame = CGRect(x: 21, y: 21, width: 36, height: 36)
        ai.startAnimating()
        mainView.addSubview(ai)
        
        let label = UILabel()
        label.text = msg
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.sizeToFit()
        mainView.addSubview(label)
        
        let wid = label.frame.height + 91
        let superFrame = CGRect(x: 0, y: 0, width: wid , height: wid)
        window.frame = UIScreen.main.bounds
        mainView.frame = superFrame
        
        ai.center.x = mainView.center.x
        label.center = CGPoint.init(x: mainView.center.x, y: ai.center.y+36) //mainView.center
        
        window.windowLevel = UIWindow.Level.alert
        mainView.center = getRealCenter()
        // change orientation
        window.transform = CGAffineTransform(rotationAngle: CGFloat(degree * Double.pi / 180))
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
    }
    
    @objc static public func wait(_ imageNames: Array<UIImage> = Array<UIImage>(), timeInterval: Int = 0) {
        let frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        let window = UIWindow()
        window.rootViewController=UIViewController.init(nibName: nil, bundle: nil)
        window.rootViewController?.view.backgroundColor=UIColor.clear
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        if imageNames.count > 0 {
            if imageNames.count > timerTimes {
                let iv = UIImageView(frame: frame)
                iv.image = imageNames.first!
                iv.contentMode = UIView.ContentMode.scaleAspectFit
                mainView.addSubview(iv)
                timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: 0), queue: DispatchQueue.main) /*Migrator FIXME: Use DispatchSourceTimer to avoid the cast*/ as? DispatchSource
//                timer?.setTimer(start: DispatchTime.now(), interval: UInt64(timeInterval) * NSEC_PER_MSEC, leeway: 0)
                timer?.setEventHandler(handler: { () -> Void in
                    let name = imageNames[timerTimes % imageNames.count]
                    iv.image = name
                    timerTimes += 1
                })
                timer?.resume()
            }
        } else {
            let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            ai.frame = CGRect(x: 21, y: 21, width: 36, height: 36)
            ai.startAnimating()
            mainView.addSubview(ai)
        }
        
        window.frame = UIScreen.main.bounds
        mainView.frame = frame
        
        window.windowLevel = UIWindow.Level.alert
        mainView.center = getRealCenter()
        // change orientation
        window.transform = CGAffineTransform(rotationAngle: CGFloat(degree * Double.pi / 180))
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
    }
    static func showText(_ text: String, autoClear: Bool, autoClearTime: Int) {
        let window = UIWindow()
        window.rootViewController=UIViewController.init(nibName: nil, bundle: nil)
        window.rootViewController?.view.backgroundColor=UIColor.clear
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.sizeToFit()
        mainView.addSubview(label)
        
        let superFrame = CGRect(x: 0, y: 0, width: label.frame.width + 50 , height: label.frame.height + 30)
        window.frame = UIScreen.main.bounds
        mainView.frame = superFrame
        
        label.center = mainView.center
        
        window.windowLevel = UIWindow.Level.alert
        mainView.center = getRealCenter()
        // change orientation
        window.transform = CGAffineTransform(rotationAngle: CGFloat(degree * Double.pi / 180))
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
    
        if autoClear {
            let selector = #selector(SwiftNotice.hideNotice(_:))
            self.perform(selector, with: window, afterDelay: TimeInterval(autoClearTime))
        }
    }
    
    static func showNoticeWithText(_ type: NoticeType,text: String, autoClear: Bool, autoClearTime: Int) {
        let frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        let window = UIWindow()
        window.rootViewController=UIViewController.init(nibName: nil, bundle: nil)
        window.rootViewController?.view.backgroundColor=UIColor.clear
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        
        var image = UIImage()
        switch type {
        case .success:
            image = SwiftNoticeSDK.imageOfCheckmark
        case .error:
            image = SwiftNoticeSDK.imageOfCross
        case .info:
            image = SwiftNoticeSDK.imageOfInfo
        }
        let checkmarkView = UIImageView(image: image)
        checkmarkView.frame = CGRect(x: 27, y: 15, width: 36, height: 36)
        mainView.addSubview(checkmarkView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 90, height: 16))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.text = text
        label.textAlignment = NSTextAlignment.center
        mainView.addSubview(label)
        
        window.frame = UIScreen.main.bounds
        mainView.frame = frame
        
        window.windowLevel = UIWindow.Level.alert
        mainView.center = getRealCenter()
        // change orientation
        window.transform = CGAffineTransform(rotationAngle: CGFloat(degree * Double.pi / 180))
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        if autoClear {
            let selector = #selector(SwiftNotice.hideNotice(_:))
            self.perform(selector, with: window, afterDelay: TimeInterval(autoClearTime))
        }
    }
    
    // fix https://github.com/johnlui/SwiftNotice/issues/2
    @objc static func hideNotice(_ sender: AnyObject) {
        if let window = sender as? UIWindow {
            window.rootViewController=nil
            for sub in window.subviews
            {
                 sub.removeFromSuperview()
            }
            if let index = windows.firstIndex(where: { (item) -> Bool in
                return item == window
            }) {
                windows.remove(at: index)
            }
        }
    }
    
    // fix orientation problem
    static func getRealCenter() -> CGPoint {
//        if UIApplication.shared.statusBarOrientation.hashValue >= 3 {
//            return CGPoint(x: rv!.center.y, y: rv!.center.x)
//        } else {
            return rv!.center
//        }
    }
}

class SwiftNoticeSDK {
    struct Cache {
        static var imageOfCheckmark: UIImage?
        static var imageOfCross: UIImage?
        static var imageOfInfo: UIImage?
    }
    class func draw(_ type: NoticeType) {
        let checkmarkShapePath = UIBezierPath()
        
        // draw circle
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        checkmarkShapePath.close()
        
        switch type {
        case .success: // draw checkmark
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error: // draw X
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()
            
            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            checkmarkShapePath.close()
            
            UIColor.white.setFill()
            checkmarkShapePath.fill()
        }
        
        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
    }
    class var imageOfCheckmark: UIImage {
        if (Cache.imageOfCheckmark != nil) {
            return Cache.imageOfCheckmark!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        
        SwiftNoticeSDK.draw(NoticeType.success)
        
        Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCheckmark!
    }
    class var imageOfCross: UIImage {
        if (Cache.imageOfCross != nil) {
            return Cache.imageOfCross!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        
        SwiftNoticeSDK.draw(NoticeType.error)
        
        Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCross!
    }
    class var imageOfInfo: UIImage {
        if (Cache.imageOfInfo != nil) {
            return Cache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        
        SwiftNoticeSDK.draw(NoticeType.info)
        
        Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfInfo!
    }
}
