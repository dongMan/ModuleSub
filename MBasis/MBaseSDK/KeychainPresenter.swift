//
//  KeychainPresenter.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 2018/5/3.
//  Copyright © 2018年 ydkt-company. All rights reserved.
//

import UIKit
import Security

@objcMembers
public class KeychainPresenter: NSObject {
    static public func getKeychainQuery(_ account:String, service:String) -> [NSString : AnyObject] {
        return [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service as AnyObject,
            kSecAttrAccount : account as AnyObject,
            kSecAttrAccessible : kSecAttrAccessibleAfterFirstUnlock
        ]
    }
    static public func save(_ account:String, service:String,data:AnyObject) {
        var keychainQuery = getKeychainQuery(account, service: service)
        let resultDelete = SecItemDelete(keychainQuery as CFDictionary);
        if resultDelete == errSecSuccess {
            print("chain删除成功")
        }else {
            print("chain删除失败")
        }
        
        keychainQuery.updateValue(NSKeyedArchiver.archivedData(withRootObject: data) as AnyObject, forKey: kSecValueData)
        let result = SecItemAdd(keychainQuery as CFDictionary, nil)
        if result == errSecSuccess {
            print("chain保存成功")
        }else {
            print("chain保存失败")
        }
    }
    
    static public func keychainLoad(_ account:String, service:String)-> AnyObject? {
        var ret:AnyObject? = nil
        var keychainQuery = getKeychainQuery(account, service: service)
        //查询结果返回到 kSecValueData
        keychainQuery.updateValue(kCFBooleanTrue, forKey: kSecReturnData)
        //只返回搜索到的第一条数据
        keychainQuery.updateValue(kSecMatchLimitOne, forKey: kSecMatchLimit)
        var keyData : CFTypeRef? = nil
        //通过条件查询数据
        let status : OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &keyData)
        if status == noErr {
            ret = NSKeyedUnarchiver.unarchiveObject(with: keyData as! Data) as AnyObject
        }else {
            print("chain查询失败")
        }
        
        return ret;
    }

    
    static public func deleteKeyData(_ account:String, service:String) {
        let keychainQuery = getKeychainQuery(account, service: service)
        SecItemDelete(keychainQuery as CFDictionary)
    }

}
