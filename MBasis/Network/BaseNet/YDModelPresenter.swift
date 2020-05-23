//
//  YDModelPresenter.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 16/4/16.
//  Copyright © 2016年 ydkt-company. All rights reserved.
//

import Foundation
import Alamofire

public class YDParamsModel: NSObject {
    // OrganizationEntity
    open var school = 0
    open var oid = 0
    
    open var userId = 0
}

public var ORG_DOMAIN: String { get { return (UserDefaults.standard.object(forKey: "kUserDefaultsDomain") ?? "") as! String } }
public func setOrgDomain(_ value: String) {
    UserDefaults.standard.set(value, forKey: "kUserDefaultsDomain")
    UserDefaults.standard.synchronize()
}

@objcMembers
public class YDModelPresenter: NSObject {
    
    public class func shareInstance() -> YDModelPresenter { return YDModelPresenter.shared }
    public static let shared = YDModelPresenter()
    
    fileprivate let kUserDefaultsToken = "kUserDefaultsToken"
    
    public var domain = HOSTURL+"/appApi/"
    public var PayUrl = HOSTURL+"/appApi/payOrder/makeOrderCode"
    public var VipPayUrl = HOSTURL+"/appApi/payOrder/makeMemberOrderCode"
    
    public var token: String = ""
    public var org_domain: String = ""
    public var bugFlag = false
    public var rsapublickey: String?
    
    public var dataTask: DataRequest?
    
    public var devInfo = [String:AnyObject]()
    public var paramModel = YDParamsModel()
    public var tokenOptions = [AnyHashable: [AnyHashable: Any]]()
    
    private override init() {
        super.init()
        devInfo["v"] = VERSION as AnyObject?
        devInfo["os"] = "1" as AnyObject?
        devInfo["osv"] = DEVICE_SYSTEAM_VERSION as AnyObject?
        devInfo["model"] = DEVICE_MODEL as AnyObject?
        devInfo["screen"] = __SCREEN_DISPLAY as AnyObject?
        devInfo["density"] = __SCREEN_SCALE as AnyObject?
        devInfo["uuid"] =  DEVICE_UDID as AnyObject?
        devInfo["optType"] = "ios" as AnyObject?
        devInfo["appType"] = (isPub ? 0 : 1) as AnyObject? // 1:代表私有包 ，0：代表公有版
        
        if let val = UserDefaults.standard.object(forKey: kUserDefaultsToken) as? String { token = val }
    }
    
    public func setToken(value: String) {
        token = value;
        UserDefaults.standard.set(value, forKey: kUserDefaultsToken)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: -  此种方式默认取出data数据 适应老接口 需要data同级字段的话z需用 YDNetRequestManager方式
    public func postWithHeader(_ url:String,params:[String:Any],headers: HTTPHeaders,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: headers, method: .post, callBack: callBack)
    }
    
    public func getWithHeader(_ url:String,params:[String:Any],headers: HTTPHeaders,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: headers, method: .get, callBack: callBack)
    }
    
    public func post(_ url:String,params:[String:Any],callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return postWithHeader(url, params: params, headers: defaultHeaders(), callBack: callBack)
    }
    
    public func get(_ url:String,params:[String:Any],callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return getWithHeader(url, params: params, headers: defaultHeaders(), callBack: callBack)
    }
    
    public func request(_ url:String,params:[String:Any],method:HTTPMethod,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: defaultHeaders(), method: method, callBack: callBack)
    }
    
    public func requestHeaders(_ url:String,params:[String:Any],headers: HTTPHeaders,method:HTTPMethod,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: headers, method: method, responseType: .json, callBack: callBack)
    }
    
    public func requestHeaders(_ url: String, params:[String:Any],headers: HTTPHeaders,method:HTTPMethod,responseType: YDNetResponseType,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest {
        
        return YDNetRequestManager.shared.requestHeaders(url, params: params, headers: headers, method: method, responseType: responseType, callBack: { (response, error) in
            if let res = response?["data"] as? [String:Any]{
                callBack(res,nil)
            }else if let flag = response?["flag"] as? Int,
                let msg = response?["msg"] as? String{
                if flag != 0 && msg.isEmpty == false{
                    callBack(nil,NSError.init(domain: msg, code: flag, userInfo: nil))
                }else{
                    callBack(response,error)
                }
            }else if let resp = response{
                callBack(resp,nil)
            }
            else{
                callBack(nil,error)
            }
        })
    }
    
    // MARK: -
    private func defaultHeaders()->HTTPHeaders{
        return ["Content-Type": "application/json"] as HTTPHeaders
    }

}
