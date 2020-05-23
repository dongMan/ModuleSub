//
//  YDNetRequestManager.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 2019/5/31.
//  Copyright © 2019 ydkt-company. All rights reserved.
//

import UIKit
import Alamofire

public enum YDNetResponseType {
    case json
    case data
    case string
}

public class YDNetRequestManager {
    
    fileprivate var agent = ""
    fileprivate let netQueue = DispatchQueue(label: "com.net.Thread")
    static public let shared : YDNetRequestManager = { return YDNetRequestManager() }()
    init() {
        getAgent()
    }
    
    // 这个鬼方法设置超时无效
    //    static let shareSessionManager:Alamofire.SessionManager = {
    //        let configuration = URLSessionConfiguration.default
    //        configuration.timeoutIntervalForRequest = 5
    //        return Alamofire.SessionManager(configuration: configuration)
    //    }()
    
    // MARK: -
    public func postWithHeader(_ url: String, params: [String:Any], headers: HTTPHeaders, callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) -> DataRequest {
        return requestHeaders(url, params: params, headers: headers, method: .post, callBack: callBack)
    }
    
    public func getWithHeader(_ url: String, params: [String:Any], headers: HTTPHeaders, callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) -> DataRequest {
        return requestHeaders(url, params: params, headers: headers, method: .get, callBack: callBack)
    }
    
    public func post(_ url:String,params:[String:Any],callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return postWithHeader(url, params: params, headers: defaultHeaders(), callBack: callBack)
    }
    /// 不做返回数据预处理的post
    public func noPreDealPost(_ url:String,params:[String:Any],callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: defaultHeaders(), method: .post, responseType: .json, noPreDeal: true, callBack: callBack)
    }
    
    public func get(_ url:String,params:[String:Any],callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return getWithHeader(url, params: params, headers: defaultHeaders(), callBack: callBack)
    }
    
    // MARK: -
    public func request(_ url:String,params:[String:Any],method:HTTPMethod,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: defaultHeaders(), method: method, callBack: callBack)
    }
    
    public func requestHeaders(_ url:String,params:[String:Any],headers: HTTPHeaders,method:HTTPMethod,callBack:@escaping (_ response:[String:Any]?,_ error:NSError?)->Void)->DataRequest{
        return requestHeaders(url, params: params, headers: headers, method: method, responseType: .json, callBack: callBack)
    }
    public  func requestHeaders(_ url: String, params: [String:Any], headers: HTTPHeaders, method: HTTPMethod, responseType: YDNetResponseType, callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) -> DataRequest{
        return requestHeaders(url, params: params, headers: headers, method: method, responseType: responseType, noPreDeal: false, callBack: callBack)
    }
    public  func requestHeaders(_ url: String, params: [String:Any], headers: HTTPHeaders, method: HTTPMethod, responseType: YDNetResponseType,noPreDeal:Bool, callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) -> DataRequest{
        
        let _params = dealParams(params)
        var _url = url
        if method == .get{
            _url = (url + "?" + FWToolKit.string(withDict: _params)).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        var _header = headers
        _header["User-Agent"] = agent
        if !ORG_DOMAIN.isEmpty{
            _header["domain"] = ORG_DOMAIN
        }
        let request = alamofireRequestHeaders(_url, params: _params, headers: _header, method: method)
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 30
        switch responseType {
        case .json:
            request.responseJSON { (result) in
                self.dealResultJson(result, url: _url, params: _params, noPreDeal: noPreDeal, callBack: callBack)
            }
            break
        case .data:
            request.responseData { (result) in
                self.dealResultData(result, url: _url, params: _params, callBack: callBack)
            }
            break
        case .string:
            request.responseString { (result) in
                self.dealResultString(result, url: _url, params: _params, callBack: callBack)
            }
        }
        
        return request
    }
    
    //MARK: - 处理
    private func alamofireRequestHeaders(_ url: String, params: [String:Any], headers: HTTPHeaders, method: HTTPMethod) -> DataRequest {
        
        let encoding = JSONEncoding.default //使用URLEncoding.default 会失败
        var urlRequest = try? URLRequest.init(url: url, method: method, headers: headers)
        var shouldOld = true
        if nil != urlRequest{
            urlRequest?.timeoutInterval = 60
            if method == .post{
                let data = try? JSONSerialization.data(withJSONObject: params, options: [])
                if let data = data{
                    urlRequest?.httpBody = data
                    shouldOld = false
                }
            } else {
                shouldOld = false
            }
        } else if method == .get {
            return Alamofire.request(url)
        }
        if shouldOld {
            return Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
        } else {
            return Alamofire.request(urlRequest!)
        }
    }
    
    private func dealResultJson(_ result: DataResponse<Any>, url: String, params: [String: Any], callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) {
        dealResultJson(result, url: url, params: params, noPreDeal: false, callBack: callBack)
    }
    private func dealResultJson(_ result: DataResponse<Any>, url: String, params: [String: Any],noPreDeal:Bool, callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void){
        result.result.ifSuccess {
            if let data = result.data {
                if url.contains("tiku/queryLastExercise") == false{
                    let resp: String = String.init(data: data, encoding: String.Encoding.utf8) ?? ""
                    print("url = \(url) \nreq = \(stringToDict(params)) \nresp = \(resp)")
                }
            }
            
            if let response = result.value as? [String:Any]{
                if noPreDeal{
                    callBack(response,nil)
                    return
                }
                var shouldBack = (false,"")
                if let flag = response["flag"] as? Int{
                    shouldBack = self.flagDeal(flag, url: url, response, nil, options: params)
                }
                if let flag = response["flag"] as? String{
                    let f = Int(flag) ?? 0
                    shouldBack = self.flagDeal(f, url: url, response, nil, options: params)
                }
                if shouldBack.0{
                    callBack(response,nil)
                }else{
                    callBack(nil,NSError.init(domain: shouldBack.1.isEmpty ? "数据格式错误":shouldBack.1, code: -1, userInfo: nil))
                }
            }else{
                callBack(nil,NSError.init(domain: "数据格式错误", code: -1, userInfo: nil))
            }
        }
        result.result.ifFailure {
            print("url = \(url) \nreq = \(stringToDict(params)) \nerror = \(result.result.error!.localizedDescription)")
            if let data = result.data,
                let str = String.init(data: data, encoding: .utf8){
                print("serve call back data is \(str)")
            }
            if result.result.error?.localizedDescription.contains("已取消") ?? false{return}
            callBack(nil,NSError.init(domain: result.result.error!.localizedDescription, code: -1, userInfo: nil))
        }
    }
    
    private func dealResultData(_ result: DataResponse<Data>, url: String, params: [String: Any], callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) {
        result.result.ifSuccess {
            if let data = result.data {
                let resp: String = String.init(data: data, encoding: String.Encoding.utf8) ?? ""
                print("url = \(url) \nreq = \(stringToDict(params)) \nresp = \(resp)")
            }
            
            if let response = result.value {
                callBack(["data":response],nil)
            } else {
                callBack(nil, NSError.init(domain: "数据格式错误", code: -1, userInfo: nil))
            }
        }
        result.result.ifFailure {
            print("url = \(url) \nreq = \(stringToDict(params)) \nerror = \(result.result.error!.localizedDescription)")
            callBack(nil,NSError.init(domain: result.result.error!.localizedDescription, code: -1, userInfo: nil))
        }
    }
    
    private func dealResultString(_ result: DataResponse<String>, url: String, params: [String: Any], callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void){
        result.result.ifSuccess {
            if let data = result.data {
                let resp: String = String.init(data: data, encoding: String.Encoding.utf8) ?? ""
                print("url = \(url) \nreq = \(stringToDict(params)) \nresp = \(resp)")
            }
            
            if let response = result.value {
                callBack(["data":response],nil)
            } else {
                callBack(nil,NSError.init(domain: "数据格式错误", code: -1, userInfo: nil))
            }
        }
        result.result.ifFailure {
            print("url = \(url) \nreq = \(stringToDict(params)) \nerror = \(result.result.error!.localizedDescription)")
            callBack(nil,NSError.init(domain: result.result.error!.localizedDescription, code: -1, userInfo: nil))
        }
    }
    
    // MARK: - tools
    private func dealParams(_ params:[String:Any])->[String:Any]{
        var op = params
        for(key,value) in YDModelPresenter.shared.devInfo { if !op.keys.contains(key) { op.updateValue(value, forKey: key) } }
        if YDModelPresenter.shared.paramModel.school > 0 {
            op.updateValue(YDModelPresenter.shared.paramModel.school, forKey: "tSchoolId")
        }
        if !YDModelPresenter.shared.token.isEmpty {
            op.updateValue(YDModelPresenter.shared.token, forKey: "token")
        }
        if !ORG_DOMAIN.isEmpty{
            op.updateValue(ORG_DOMAIN, forKey: "domain")
        }
        return op
    }
    
    private func defaultHeaders()->HTTPHeaders{
        return ["Content-Type": "application/json"] as HTTPHeaders
    }
    
    private func getAgent(){
        let mBundle = Bundle.main
        var str = ""
        if let tmp = mBundle.infoDictionary?[String(kCFBundleExecutableKey)] as? String{
            str = tmp
        }else if let tmp = mBundle.infoDictionary?[String(kCFBundleIdentifierKey)] as? String{
            str = tmp
        }
        
        var version = mBundle.infoDictionary?[String(kCFBundleVersionKey)] as? String ?? ""
        let device = UIDevice.current
        agent = "\(str)/\(version) (\(device.model); iOS \(device.systemVersion);Scale/\(String.init(format: "%.2f", UIScreen.main.scale)))"
    }
    
    private func stringToDict(_ dict: [String: Any]) -> String {
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            return String.init(data: data, encoding: .utf8) ?? ""
        }
        return "";
    }
}
extension YDNetRequestManager {
    private func flagDeal(_ flag: Int, url: String, _ response: [String: Any]?, _ error: NSError?, options: [String: Any]) -> (Bool,String) {
        var shouldCallBack = true
        let msg = response?["msg"] as? String ?? ""
        var backMsg = ""
        YDModelPresenter.shared.tokenOptions.removeValue(forKey: url)
        
        if(flag == 100) {
            // TODO:- 更新token
            YDModelPresenter.shared.tokenOptions.updateValue(options, forKey: url)
            YDModelPresenter.shared.getUserToken(url: url, logOut: false, completed: { (response:[AnyHashable:Any]?, error:NSError?) in
                if let win = UIApplication.shared.delegate?.window,
                    let nav = win?.rootViewController as? UINavigationController,
                    let topVC = nav.topViewController{
                    topVC.noticeOnlyText(msg)
                }
            })
        } else if flag == -2 {
            //TODO:- 强制退出
            NotificationCenter.default.post(name: kNotificationForceQuit, object: msg)
            shouldCallBack = false
        ///["getStatusByFunctionCode","appFinishOrder/"] 以flag为判断依据俩接口 同时可能用到其他数据 而不仅仅是hud提示错误
        } else if flag == 20 {
           //TODO:- 禁用学员APP登录
            NotificationCenter.default.post(name: kNotificationForceProhibit, object: msg)
            shouldCallBack = false
        }
        else if flag != 0 && !isOtherUrls(url){
            shouldCallBack = false
            backMsg = msg
        }
        return (shouldCallBack,backMsg)
    }
    
    fileprivate func isOtherUrls(_ url:String)->Bool{
        var isOther = false
        let otherUrls = ["getStatusByFunctionCode",
                         "appFinishOrder/",
                         "ccapi.csslcloud.net/api/room/auth",
                         "user/validatePwdComplexity"]
        otherUrls.forEach { (otherUrl) in
            if url.contains(otherUrl){
                isOther = true
            }
        }
        return isOther
    }
}
// MARK: - 主线程方法
extension YDNetRequestManager{
    public func postWithData(_ params:String,url:String,callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) -> DataRequest?{
        let _header = defaultHeaders()
        var  headers = _header
        headers["User-Agent"] = agent
        guard var urlRequest = try? URLRequest.init(url: url, method: .post, headers: headers) else{
            callBack(nil,NSError.init(domain: "url有误", code: -1, userInfo: nil))
            return nil
        }
        guard let data = try? params.data(using: .utf8) else{callBack(nil,NSError.init(domain: "params有误", code: -1, userInfo: nil));return nil}
        urlRequest.timeoutInterval = 20
        urlRequest.httpBody = data
        return Alamofire.request(urlRequest).responseJSON(queue: DispatchQueue.main, options: .allowFragments, completionHandler: { (result) in
            self.dealResultJson(result, url: url, params: ["params":params], callBack: callBack)
        })
    }
}

// MARK: - 子线程方法
extension YDNetRequestManager{
    public func postThreadWithData(_ params:String,url:String,callBack: @escaping (_ response: [String:Any]?, _ error: NSError?) -> Void) -> DataRequest?{
        let _header = defaultHeaders()
        var  headers = _header
        headers["User-Agent"] = agent
        guard var urlRequest = try? URLRequest.init(url: url, method: .post, headers: headers) else{
            callBack(nil,NSError.init(domain: "url有误", code: -1, userInfo: nil))
            return nil
        }
        guard let data = try? params.data(using: .utf8) else{callBack(nil,NSError.init(domain: "params有误", code: -1, userInfo: nil));return nil}
        urlRequest.timeoutInterval = 20
        urlRequest.httpBody = data
        return Alamofire.request(urlRequest).responseJSON(queue: netQueue, options: .allowFragments, completionHandler: { (result) in
            self.dealResultJson(result, url: url, params: ["params":params], callBack: callBack)
        })
    }
}

extension YDNetRequestManager{
    // MARK : - 上传图片专用
    public func uploadImages(_ url: String, images: [UIImage], params: [String: String], headers: HTTPHeaders, method: HTTPMethod, callBack: @escaping (_ response: [String: Any]?, _ error: NSError?) -> Void) {
        
        let dataArr = images.compactMap { (image) -> Data? in
            var imageData = image.jpegData(compressionQuality: 1.0)
            let size = CGFloat((imageData?.count)!)/1024.0/1024
            if (size>=1) {
                imageData = image.jpegData(compressionQuality: 0.3)
            } else {
                imageData = image.jpegData(compressionQuality: 0.8)
            }
            return imageData
        }
        var _header = headers
        _header["User-Agent"] = agent
        guard var urlRequest = try? URLRequest.init(url: url, method: method, headers: _header) else{callBack(nil,NSError.init(domain: "初始化请求失败", code: -1, userInfo: nil));return}
        urlRequest.timeoutInterval = 30
        Alamofire.upload(multipartFormData: { (formData) in
            for (i,data) in dataArr.enumerated() {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                var name = formatter.string(from: Date())
                name = name+String(i)+".jpg"
                formData.append(data, withName: "imageStreams", fileName: name, mimeType: "image/jpeg")
            }
            for (key,value) in params{
                formData.append(value.data(using: .utf8)!, withName: key)
            }
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { result in
                    self.dealResultJson(result, url: url, params: params, callBack: callBack)
                }
            case .failure(let encodingError):
                if encodingError.localizedDescription.contains("已取消") {return}
                callBack(nil,NSError.init(domain: encodingError.localizedDescription, code: -1, userInfo: nil))
            }
        }
    }
}
