//
//  FWDeviceInfo.h
//  IOS_SDK
//
//  Created by ydkt-author on 15/12/10.
//  Copyright © 2015年 360.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachabilityExt : NSObject

@property(nonatomic,readonly) NSNumber* networkState; // 0=Unknown，1=WIFI，2=2G，3=3G，4=4G

+ (ReachabilityExt *)shareInstance;

+ (int) networkState;

@end
