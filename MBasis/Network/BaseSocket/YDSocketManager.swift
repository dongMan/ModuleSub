//
//  YDSocketManager.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 2018/6/12.
//  Copyright © 2018年 ydkt-company. All rights reserved.
//

import UIKit
import SocketIO

public let kNotificationSocketFrontLogout = Notification.Name(rawValue: "kNotificationSocketFrontLogout")

@objcMembers
public class YDSocketManager: NSObject {
    
   fileprivate var manager : SocketManager?
   fileprivate  var socket : SocketIOClient?
    
    class func shareInstance() -> YDSocketManager {
        return YDSocketManager.shared
    }
    
    public static let shared : YDSocketManager = YDSocketManager()

    public func socketStart(_ token : String){
        offSocket()
        socket = nil
        
        YDModelPresenter.shared.getdomain({ (response, error) in
            if nil == error{
                var url = ""
                if let tmp = response?["data"] as? String { url = tmp }
                self.socketStart2(url, token);
            }else{
                print(error!.domain)
            }
        })
    }
    
    func socketStart2(_ url : String, _ token : String){
        let option = ["yunId": token, "additional": "5", "domain" : ORG_DOMAIN, "sessionid": token];
        guard let _url = URL.init(string: url) else {return}
        manager = SocketManager(socketURL: _url, config: [.log(false), .compress, .connectParams(option)])
        socket = manager?.defaultSocket
        
        // 监听是否连接上服务器，正确连接走后面的回调
        socket?.on(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.socket?.emit("front_logout", with: [])
        }
        socket?.on("front_logout") { (data, ack) in
            print("socket front_logout");
            NotificationCenter.default.post(name: kNotificationForceQuit, object: nil)
        }
        socket?.on(clientEvent: .statusChange) { (data, ack) in
            print("socket statusChange:\(String(describing: self.socket?.status))")
        }
        socket?.on(clientEvent: .disconnect) { (data, ack) in
            print("what happ")
        }
        socket?.on(clientEvent: .error) { (data, ack) in
            print("what error")
        }
        socket?.connect();
    }
    
    func offSocket() {
        socket?.disconnect()
        socket?.off(clientEvent: .connect)
        socket?.off("front_logout")
        socket?.off(clientEvent: .statusChange)
        socket?.off(clientEvent: .disconnect)
        socket?.off(clientEvent: .error)
    }
    
    func keepAlive(){
        let socketData = ["": "serviceAlive"] as [String : Any]
        socket?.emit("message", socketData)
        if socket?.status == .connected {
            print("还活着。。。。。。。。。没有断掉")
        }
        
    }
}
