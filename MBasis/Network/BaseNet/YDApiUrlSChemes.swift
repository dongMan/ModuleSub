//
//  YDApiUrlSChemes.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 2019/6/28.
//  Copyright © 2019 ydkt-company. All rights reserved.
//

import UIKit

public let HOST_SCHEME = HOSTURL + "/appApi/"

public class YDApiUrlSChemes: NSObject {
    
    /// socketUrl
    class func socketUrl()->String{
        return SOCKET_URL + "api/getdomain"
    }

    /// 获取用户Token
    class func getUserToken() -> String {
        return HOST_SCHEME + "company/getUserToken"
    }
    
    
}
