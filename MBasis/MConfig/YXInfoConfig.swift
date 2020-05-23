
//
//  YXInfoConfig.swift
//  ydkt-product-name
//
//  Created by ydkt-author on 1/10/19.
//  Copyright © 2019 ydkt-company. All rights reserved.
//


//public var HOSTURL = "http://sdk.live.cunwedu.com.cn"
//
//public var SOCKET_URL = "http://sso.live.cunwedu.com.cn/"
//public var IMAGE_URL  = "http://pic.live.cunwedu.com.cn/"
//public var HOSTURL="http://sdk.rel.yunduoketang.cn"
public var HOSTURL="http://sdk.dev.yunduoketang.cn"
//public var HOSTURL = "https://sdk.yunduoketang.com"


public var SOCKET_URL = "http://nodeyuan.yunduoketang.cn/"
public var IMAGE_URL  = "http://image.yunduoketang.com/"


public var JPUSH_APPKEY = ""
public var UMeng_APPKEY = "573702d167e58e4c28003f44"
public var Ali_SCHEME = "newcloud.hunan.alipay"
public var WX_APPKEY = ""
public let WX_SCOPE  = "snsapi_userinfo"
public let WX_STATE  = "596ad2c413568db8440162f491597e4a"

// 机构ID
public let ORG_COMPANY_ID = ""//138259
public let ORG_MAIN_DOMAIN = ""

// 内购价格
public let purchase = [208,998,1998]

public let money_unit = YDModelPresenter.shared.bugFlag ? "￥" : "￥"
public let money_unit_single = YDModelPresenter.shared.bugFlag ? "¥" : "¥"

public let ENVIRONMENT_DEV = "dev"
public let ENVIRONMENT_STAGING = "staging"
public let ENVIRONMENT_PROD = "prod"
public let ENVIRONMENT_DISTRIBUTION = "distributton"

public var ENVIRONMENT : String =  ENVIRONMENT_PROD

