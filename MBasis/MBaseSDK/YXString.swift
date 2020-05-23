//
//  MLString.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 2018/3/29.
//  Copyright © 2018年 ydkt-company. All rights reserved.
//

import UIKit

extension String {

    /// 从String中截取出参数
    public var urlParameters: [String: AnyObject]? {
        get {
            // 判断是否有参数
            guard let start = self.range(of: "?") else { return nil }
            
            var params = [String: Any]()
            let paramsString = self.substring(from: start.upperBound)
            
            // 判断参数是单个参数还是多个参数
            if paramsString.contains("&") {
                let mAComp = paramsString.components(separatedBy: "&")
                for element in mAComp {
                    let mATmp = element.components(separatedBy: "=")
                    guard mATmp.count != 1 else { return nil }
                    
                    let key = mATmp.first?.removingPercentEncoding
                    let value = mATmp.last?.removingPercentEncoding
                    if let _key = key, let _value = value {
                        if let exist = params[_key] {
                            if var _val = exist as? [Any] { _val.append(_value) }
                            else { params.updateValue([exist, _value], forKey: _key) }
                        }
                        else { params.updateValue(_value, forKey: _key) }
                    }
                }
            }
            else {
                let mATmp = paramsString.components(separatedBy: "=")
                guard mATmp.count != 1 else { return nil }
                
                let key = mATmp.first?.removingPercentEncoding
                let value = mATmp.last?.removingPercentEncoding
                if let _key = key, let _value = value { params.updateValue(_value, forKey: _key) }
            }
            
            return params as [String : AnyObject]
        }
    }
}

