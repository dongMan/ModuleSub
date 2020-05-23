//
//  YXBaseConfig.swift
//  AFNetworking
//
//  Created by ydkt-author on 3/26/19.
//

import Foundation

// 版本号
public let VERSION      = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let BUILDVERSION = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
public let APPNAME      = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String


// bundle Id
public let BUNDLEID: String = Bundle.main.bundleIdentifier ?? ""

// 设备系统版本
public let DEVICE_SYSTEAM_VERSION: String = UIDevice.current.systemVersion
// 设备名称
public let DEVICE_SYSTEAM_NAME: String = UIDevice.current.systemName
// 设备别名-用户定义的名称
public let DEVICE_USER_NAME: String = UIDevice.current.name
// 设备型号
public let DEVICE_MODEL: String = UIDevice.current.model
// 地方型号（国际化区域名称）
public let DEVICE_LOCALIZED_MODEL: String = UIDevice.current.localizedModel

// 设备标示符号
public var DEVICE_UDID: String {
    get {
        guard let strUUID = KeychainPresenter.keychainLoad(BUNDLEID, service: BUNDLEID) as? String else {
//            var uuid = ASIdentifierManager.shared.advertisingIdentifier.UUIDString //AdSupport
            var uuid = UUID().uuidString;
            // 00000000-0000-0000-0000-000000000000
            if uuid == "00000000-0000-0000-0000-000000000000" { uuid = UUID().uuidString; }
            
            //将该uuid保存到keychain
            KeychainPresenter.save(BUNDLEID, service: BUNDLEID, data: uuid as AnyObject)
            return uuid
        }
        return strUUID
    }
}


public var HasWXURLType: Bool {
    get {
        if let urlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [[AnyHashable: Any]] {
            for urlType in urlTypes {
                if let urlName = urlType["CFBundleURLName"] as? String, urlName == "weixin" {
                    return true
                }
            }
        }
        return false
    }
}
public var isPub : Bool { get { return ORG_COMPANY_ID.count < 1 } }
