//
//  YXBaseConfig.swift
//  AFNetworking
//
//  Created by ydkt-author on 3/26/19.
//

import Foundation

// 这些方法往上层了拿

// MARK: - page begin
public let pageMax = 10  // 每页加载数量
// MARK: - page end

public var YDPackageName = "课程包"

// MARK: - search begin 搜索历史
public var UD_CourseSearchKey = "courseSearchHis"+String(schoolId)
public var UD_PacketSearchKey = "packetSearchHis"+String(schoolId)
public var schoolId = 0{
    didSet{
        UD_CourseSearchKey = "courseSearchHis"+String(schoolId)
        UD_PacketSearchKey = "packetSearchHis"+String(schoolId)
    }
}
// MARK: - search end

// MARK: - jpush begin
public let kUserDefaultsPushMessage =  "kUserDefaultsPushMessage"
public func setMessageValue(_ value: String) {
    var val = ""
    if let tmp = UserDefaults.standard.object(forKey: kUserDefaultsPushMessage) as? String { val = tmp }
    
    if val != value {
        var saveValue = value;
        let num = Int(value) ?? 0
        if num > 99 { saveValue = "99+" }
        UserDefaults.standard.set(saveValue, forKey: kUserDefaultsPushMessage)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: kNotificationPushMessage, object: nil)
    }
}
// MARK: - jpush end


// oc 相互关联 方法
public var isHiddenNavBar: Bool = false
public var YXBaseClass_nologinTopicNum: Int = 0
@objcMembers public class YXBaseClass: NSObject {
    private override init() {}
    
    open class func setNologinTopicNum(num: Int) { YXBaseClass_nologinTopicNum = num }
    open class func getNologinTopicNum() -> Int { return YXBaseClass_nologinTopicNum }
    open class func colorTitle() -> UIColor { return color_333333 }
    open class func isHiddenNavigationBar() -> Bool { return isHiddenNavBar }
}
