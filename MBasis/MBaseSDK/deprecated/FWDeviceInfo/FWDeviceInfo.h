//
//  FWDeviceInfo.h
//  IOS_SDK
//
//  Created by ydkt-author on 15/12/10.
//  Copyright © 2015年 360.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// 设备型号的枚举值

typedef NS_ENUM(NSUInteger, DiviceType) {
    
    iPhone_1G = 0,
    
    iPhone_3G,
    
    iPhone_3GS,
    
    iPhone_4,
    
    iPhone_4_Verizon,
    
    iPhone_4S,
    
    iPhone_5_GSM,
    
    iPhone_5_CDMA,
    
    iPhone_5C_GSM,
    
    iPhone_5C_GSM_CDMA,
    
    iPhone_5S_GSM,
    
    iPhone_5S_GSM_CDMA,
    
    iPhone_6,
    
    iPhone_6_Plus,
    
    iPhone_6S,
    
    iPhone_6S_Plus,
    
    iPhone_SE,
    
    Chinese_iPhone_7,
    
    Chinese_iPhone_7_Plus,
    
    American_iPhone_7,
    
    American_iPhone_7_Plus,
    
    Chinese_iPhone_8,
    
    Chinese_iPhone_8_Plus,
    
    Chinese_iPhone_X,
    
    Global_iPhone_8,
    
    Global_iPhone_8_Plus,
    
    Global_iPhone_X,
    
    
    
    iPod_Touch_1G,
    
    iPod_Touch_2G,
    
    iPod_Touch_3G,
    
    iPod_Touch_4G,
    
    iPod_Touch_5Gen,
    
    iPod_Touch_6G,
    
    
    iUnknown,
    
};


@interface FWDeviceInfo : NSObject<CLLocationManagerDelegate>

@property(nonatomic,readonly) NSString* appName;
@property(nonatomic,readonly) NSString* bundleID;
@property(nonatomic,readonly) NSString* appVersion;

@property(nonatomic,readonly) NSString* systemVersion;
@property(nonatomic,readonly) NSString* IDFA;//
@property(nonatomic,readonly) NSString* uuid;
@property(nonatomic,readonly) NSString* BSSID;
@property(nonatomic,readonly) NSString* SSID;
@property(nonatomic,readonly) NSString* deviceName;
@property(nonatomic,readonly) DiviceType deviceEnumType;//
@property(nonatomic,readonly) NSString* deviceType;
@property(nonatomic,readonly) NSString* screenDisplay;//1080x1920
@property(nonatomic,readonly) CGSize screenSize;
@property(nonatomic,readonly) NSNumber* deviceScale;
@property(nonatomic,readonly) NSNumber* orientation;
@property(nonatomic,readonly) NSString* carrierType;
@property(nonatomic,readonly) NSNumber* jailBroken;//越狱或破解 0 未越狱，1 越狱
@property(nonatomic,readonly) NSNumber* networkState; //  //0=Unknown，1=WIFI，2=2G，3=3G，4=4G
@property(nonatomic,readonly) CLLocationCoordinate2D location;//使用半角逗号隔开
@property(nonatomic,readonly) NSString* language;
@property(nonatomic,assign) BOOL enableLocation;
@property(nonatomic,readonly) NSNumber*screenH;
@property(nonatomic,readonly) NSNumber*screenW;

+ (FWDeviceInfo *)shareInstance;

@end
