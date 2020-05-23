//
//  YXBaseConfig.swift
//  AFNetworking
//
//  Created by ydkt-author on 3/26/19.
//

import Foundation

public let kNotificationDeeplinkCourse = Notification.Name(rawValue: "DeeplinkCourse")
public let kNotificationCachesManageRemoveAll = NSNotification.Name(rawValue: "CachesManageRemoveAll")
public let kNotificationGetCurrtCopany = NSNotification.Name(rawValue: "kNotificationGetCurrtCopany")
public let kNotificationRefreshCourse =  NSNotification.Name(rawValue: "refreshCourse")
public let kNotificationPaySuccess = NSNotification.Name(rawValue: "kNotificationPaySuccess")
public let kNotificationIapPaySuccess = NSNotification.Name(rawValue: "kNotificationIapPaySuccess")

public let kNotificationQueryMyOrder = NSNotification.Name(rawValue: "queryMyOrder")
public let kNotificationQueryMyCourse = NSNotification.Name(rawValue: "queryMyCourse")
public let kNotificationQueryMyAccount = NSNotification.Name(rawValue: "myAccount")
public let kNotificationQueryMyMember = NSNotification.Name(rawValue: "queryMember")

public let kNotificationReloadFootTabBar = NSNotification.Name(rawValue: "reloadFootTabBar")
public let kNotificationReloadHeadNav = NSNotification.Name(rawValue: "kNotificationReloadHeadNav")

public let kNotificationLoginSucess = NSNotification.Name(rawValue: "kNotificationLoginSucess")
public let kNotificationChangeSchool = NSNotification.Name(rawValue: "kNotificationChangeSchool")

public let kNotificationPushMessage =  NSNotification.Name(rawValue: "kNotificationPushMessage")
public let kNotificationPushCoupon =  NSNotification.Name(rawValue: "kNotificationPushCoupon")
public let kNotificationPushBalance =  NSNotification.Name(rawValue: "kNotificationPushBalance")
public let kNotificationForceQuit =  NSNotification.Name(rawValue: "kNotificationForceQuit")
public let kNotificationBlvsLocalBackNoti =  NSNotification.Name(rawValue: "kNotificationBlvsLocalBackNoti")
public let kNotificationForceProhibit =  NSNotification.Name(rawValue: "kNotificationForceProhibit")

public let kUserDefaultsSchoolSuffixId = "kUserDefaultsSchoolSuffixId"

public let kUserDefaultsAskProtocolStatus = "kUserDefaultsAskProtocolStatus_\(YDModelPresenter.shared.paramModel.userId)"

public let UD_AudioKey = "audioNeedStop"
public let UD_EnvKey = "yd_env_change"
public let UD_DmKey = "yd_zs_dmKey"
