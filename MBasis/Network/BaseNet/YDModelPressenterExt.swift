//
//  YDModelPressenterExt.swift
//  AFNetworking
//

import UIKit


@_exported import HandyJSON
@_exported import Alamofire
extension YDModelPresenter {
    
    //  (welcom  / 登录后) 重新获取token
    public func getUserToken(url: String?, logOut: Bool, completed handle: @escaping (([AnyHashable: Any]?,_ error:NSError?) ->Void) ) {
        var options = ["companyId": paramModel.oid]

        //退出时 logOut = true userid 为空
        if logOut != true {
            if 0 != paramModel.userId {
                options.updateValue(paramModel.userId , forKey: "userId")
            }
        }
        
        dataTask = post(YDApiUrlSChemes.getUserToken(), params: options, callBack: {(response: [AnyHashable: Any]?, error: NSError?) in
            if let resp = response {
                if let _token = resp["data"] as? String {
                    self.token = _token
                    YDModelPresenter.shared.setToken(value: _token)
                    
                    if let uuid = self.devInfo["uuid"] as? String {
                        YDSocketManager.shared.socketStart(uuid);
                    }
                    
                    if let _url = url {
                        if var option = self.tokenOptions[_url] {
                            option.updateValue(_token, forKey: "token")
                            self.resetReqManager(url: _url, options: option, completed: handle)
                            return;
                        }
                    }
                }
            }
            handle(response, error)
        })
    }
    
    func resetReqManager(url: String, options: [AnyHashable: Any], completed handle: @escaping (([AnyHashable: Any]?,_ error:NSError?) ->Void) ) {
        dataTask = post(url, params: options as! [String : Any], callBack:handle)
    }
    
    
    public func getdomain(_ handle: @escaping (([AnyHashable: Any]?,_ error:NSError?) -> Void) ) {
        if paramModel.oid != 0 && paramModel.school != 0 {
            let companyId = paramModel.oid
            let schoolId  = paramModel.school
            let userId = paramModel.userId
            let params = ["companyId": companyId, "platform":"app", "schoolId": schoolId, "userId": userId] as [String : Any]
            let headers = ["Content-Type": "application/json"] as HTTPHeaders
            _ = requestHeaders(YDApiUrlSChemes.socketUrl(), params: params, headers: headers, method: .get, responseType: .string, callBack: handle)
        }
    }
    
}
