//
//  FWDeviceInfo.m
//  IOS_SDK
//
//  Created by ydkt-author on 15/12/10.
//  Copyright © 2015年 360.cn. All rights reserved.
//
#import "ReachabilityExt.h"

#import "Reachability.h"

@implementation ReachabilityExt {
    Reachability *reachability;
}

@synthesize networkState;

static ReachabilityExt *_shareInstance = nil;

+ (ReachabilityExt *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}

+ (id) allocWithZone:(NSZone *)zone {
    @synchronized(self){
        if (_shareInstance == nil) {
            _shareInstance = [super allocWithZone:zone];
            return  _shareInstance;
        }
    }
    return nil;
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kFWReachabilityChangedNotification object:nil];
       // 
    }
    return self;
}


+ (int) networkState {
    return [[[ReachabilityExt shareInstance] networkState] intValue];
}

#pragma mark 网络状态
//-(void)reachabilityChanged:(NSNotification*) info
//{
//    FWNetworkStatus ns = [reachability currentReachabilityStatus];
//    networkState=@((int)ns);
//}

- (nonnull NSNumber*) networkState {
    if (reachability == nil) {
        reachability = [Reachability reachabilityWithHostName:@"www.360.com"];
        [reachability startNotifier];
    }
    
    NetworkStatus ns = [reachability currentReachabilityStatus];
    if (ns == NotReachable) networkState=@(0);
    else if (ns == ReachableViaWiFi) networkState=@(1);
    else if (ns == ReachableViaWWAN) networkState=@(2);
    
    return networkState;
}

@end
