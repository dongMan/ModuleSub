//
//  FWDeviceInfo.m
//  IOS_SDK
//
//  Created by ydkt-author on 15/12/10.
//  Copyright © 2015年 360.cn. All rights reserved.
//
#import "FWDeviceInfo.h"

#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h> // ssid

#include <sys/types.h>
#include <sys/sysctl.h>//deviceType

#include <sys/utsname.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import <sys/stat.h>//checkCydia
#import <dlfcn.h>//checkInject
#import <mach-o/dyld.h>//checkDylibs

#import <Reachability/Reachability.h>
//#import "Te"
#import <MBasis/MBasis-Swift.h>




@implementation FWDeviceInfo
{
    Reachability *reachability;
    CLLocationManager *locationManager;
}
@synthesize location,enableLocation,networkState;

static FWDeviceInfo *_shareInstance = nil;
+ (FWDeviceInfo *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}

+(id) allocWithZone:(NSZone *)zone {
    @synchronized(self){
        if (_shareInstance == nil) {
            _shareInstance = [super allocWithZone:zone];
            return  _shareInstance;
        }
    }
    return nil;
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (instancetype)init
{
    if (self = [super init])
    {
        location=CLLocationCoordinate2DMake(0,0);
        enableLocation=YES;
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kFWReachabilityChangedNotification object:nil];
       // 
    }
    return self;
}
- (nonnull NSString*)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}
- (nonnull NSString*)bundleID
{
    return [NSBundle mainBundle].bundleIdentifier;
}
- (nonnull NSString*)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
- (nonnull NSString*)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}



- (nonnull NSString*) uuid {
    NSString * ID = self.bundleID;
    NSString * strUUID = (NSString *)[KeychainPresenter keychainLoad:ID service:ID];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID) {
        strUUID = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
        //00000000-0000-0000-0000-000000000000
        if ([strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
            //生成一个uuid的方法
            CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        }
        //将该uuid保存到keychain
        [KeychainPresenter save:ID service:ID data:strUUID];
    }
    return strUUID;
}

- (nonnull NSString*)IDFA {
    NSString * ID = self.bundleID;
    NSString * strUUID = (NSString *)[KeychainPresenter keychainLoad:ID service:ID];

    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID) {
        strUUID = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
        //00000000-0000-0000-0000-000000000000
        if ([strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
            //生成一个uuid的方法
            CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        }
        //将该uuid保存到keychain
        [KeychainPresenter save:ID service:ID data:strUUID];
    }
    return strUUID;
}
    
- (nonnull NSString*)BSSID
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString*_BSSID=@"";
    for (NSString *ifnam in ifs)
    {
        NSDictionary* networkInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (networkInfo)
        {
            _BSSID=networkInfo[@"BSSID"];
            break;
        }
    }
    return _BSSID;
}
- (nonnull NSString*)SSID
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString*_SSID=@"";
    for (NSString *ifnam in ifs)
    {
        NSDictionary* networkInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (networkInfo)
        {
            _SSID=networkInfo[@"SSID"];
            break;
        }
    }
    return _SSID;
}
-(nonnull NSString*)deviceName
{
    return [[UIDevice currentDevice] name];
}
-(nonnull NSString*)deviceType
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

-(DiviceType)deviceEnumType{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *machineString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    

    if ([machineString isEqualToString:@"iPhone1,1"])   return iPhone_1G;
    
    if ([machineString isEqualToString:@"iPhone1,2"])   return iPhone_3G;
    
    if ([machineString isEqualToString:@"iPhone2,1"])   return iPhone_3GS;
    
    if ([machineString isEqualToString:@"iPhone3,1"])   return iPhone_4;
    
    if ([machineString isEqualToString:@"iPhone3,3"])   return iPhone_4_Verizon;
    
    if ([machineString isEqualToString:@"iPhone4,1"])   return iPhone_4S;
    
    if ([machineString isEqualToString:@"iPhone5,1"])   return iPhone_5_GSM;
    
    if ([machineString isEqualToString:@"iPhone5,2"])   return iPhone_5_CDMA;
    
    if ([machineString isEqualToString:@"iPhone5,3"])   return iPhone_5C_GSM;
    
    if ([machineString isEqualToString:@"iPhone5,4"])   return iPhone_5C_GSM_CDMA;
    
    if ([machineString isEqualToString:@"iPhone6,1"])   return iPhone_5S_GSM;
    
    if ([machineString isEqualToString:@"iPhone6,2"])   return iPhone_5S_GSM_CDMA;
    
    if ([machineString isEqualToString:@"iPhone7,2"])   return iPhone_6;
    
    if ([machineString isEqualToString:@"iPhone7,1"])   return iPhone_6_Plus;
    
    if ([machineString isEqualToString:@"iPhone8,1"])   return iPhone_6S;
    
    if ([machineString isEqualToString:@"iPhone8,2"])   return iPhone_6S_Plus;
    
    if ([machineString isEqualToString:@"iPhone8,4"])   return iPhone_SE;
    
    
    
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    
    if ([machineString isEqualToString:@"iPhone9,1"])   return Chinese_iPhone_7;
    
    if ([machineString isEqualToString:@"iPhone9,2"])   return Chinese_iPhone_7_Plus;
    
    if ([machineString isEqualToString:@"iPhone9,3"])   return American_iPhone_7;
    
    if ([machineString isEqualToString:@"iPhone9,4"])   return American_iPhone_7_Plus;
    
    if ([machineString isEqualToString:@"iPhone10,1"])  return Chinese_iPhone_8;
    
    if ([machineString isEqualToString:@"iPhone10,4"])  return Global_iPhone_8;
    
    if ([machineString isEqualToString:@"iPhone10,2"])  return Chinese_iPhone_8_Plus;
    
    if ([machineString isEqualToString:@"iPhone10,5"])  return Global_iPhone_8_Plus;
    
    if ([machineString isEqualToString:@"iPhone10,3"])  return Chinese_iPhone_X;
    
    if ([machineString isEqualToString:@"iPhone10,6"])  return Global_iPhone_X;
    
    
    
    if ([machineString isEqualToString:@"iPod1,1"])     return iPod_Touch_1G;
    
    if ([machineString isEqualToString:@"iPod2,1"])     return iPod_Touch_2G;
    
    if ([machineString isEqualToString:@"iPod3,1"])     return iPod_Touch_3G;
    
    if ([machineString isEqualToString:@"iPod4,1"])     return iPod_Touch_4G;
    
    if ([machineString isEqualToString:@"iPod5,1"])     return iPod_Touch_5Gen;
    
    if ([machineString isEqualToString:@"iPod7,1"])     return iPod_Touch_6G;

    return iUnknown;
}

-(nonnull NSNumber*)screenH
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    /*for ipad分屏,只取当前app的屏幕分辨率*/
    if ([UIApplication sharedApplication].keyWindow) {
        size = [UIApplication sharedApplication].keyWindow.frame.size;
    }
    return @(MIN(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]));
}
-(nonnull NSNumber*)screenW
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    /*for ipad分屏,只取当前app的屏幕分辨率*/
    if ([UIApplication sharedApplication].keyWindow) {
        size = [UIApplication sharedApplication].keyWindow.frame.size;
    }
    return @(MAX(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]));
}

-(nonnull NSString*)screenDisplay
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    /*for ipad分屏,只取当前app的屏幕分辨率*/
    if ([UIApplication sharedApplication].keyWindow) {
        size = [UIApplication sharedApplication].keyWindow.frame.size;
    }
    return [NSString stringWithFormat:@"%.0fx%.0f",MIN(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]),MAX(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale])];
}
-(nonnull NSNumber*)deviceScale
{
    return @([[UIScreen mainScreen] scale]);
}
-(nonnull NSNumber*)orientation
{
     UIInterfaceOrientation _orientation=[[UIApplication sharedApplication] statusBarOrientation];
    if(UIInterfaceOrientationIsPortrait(_orientation))
    {
        return @(2);
    }
    if(UIInterfaceOrientationIsLandscape(_orientation))
    {
        return @(1);
    }
    return @(0);
}
-(nonnull NSString*)carrierType
{
    NSString* _operators=@"na";
    if (NSClassFromString(@"CTTelephonyNetworkInfo"))
    {
        CTCarrier *carrier = [[CTTelephonyNetworkInfo alloc] init].subscriberCellularProvider;
        if (carrier)
        {
            if ([[carrier carrierName] length]>0)
            {
                _operators = [carrier carrierName];
            }
        }
    }
    return _operators;
}
#pragma mark 是否越狱
static int checkCydia(void)
{
    int ret =-1;
    struct stat stat_info;
    ret=stat("/Applications/Cydia.app", &stat_info);
    if (0 != ret) {
        ret = stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info);
    }
    return ret;
}
static int checkInject(void)
{
    int ret =-1;
    Dl_info dylib_info;
    int (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info)))
    {
       // NSLog(@"lib :%s", dylib_info.dli_fname);
        ret=strcmp("/usr/lib/system/libsystem_kernel.dylib", dylib_info.dli_fname);
    }
    return ret;
}
static int checkDylibs(void)
{
    int ret =-1;
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i)
    {
        ret=strcmp("Library/MobileSubstrate/MobileSubstrate.dylib", _dyld_get_image_name(i));
       // NSLog(@"--%s", _dyld_get_image_name(i));
        if (ret==0) {
            break;
        }
    }
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    //NSLog(@"checkDylibs--%s", env);
    return ret;
}
-(nonnull NSNumber*)jailBroken
{
    int ret =0;
    if(checkCydia()==0)
    {
        ret=1;
    }
    else if(checkInject()==0)
    {
        ret=1;
    }
    else if(checkDylibs()==0)
    {
        ret=1;
    }
    return @(ret);
}
#pragma mark 网络状态
//-(void)reachabilityChanged:(NSNotification*) info
//{
//    FWNetworkStatus ns = [reachability currentReachabilityStatus];
//    networkState=@((int)ns);
//}
-(nonnull NSNumber*) networkState {
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

#pragma mark 地理位置
-(void) setEnableLocation:(BOOL)_enableLocation
{
    enableLocation=_enableLocation;
    if(enableLocation)
    {
        [self location];
    }
    else
    {
        [locationManager stopUpdatingLocation];
    }
}
-(CLLocationCoordinate2D)location
{
    if(!self.enableLocation)
    {
        return CLLocationCoordinate2DMake(0,0);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if(locationManager==nil)
        {
            locationManager=[[CLLocationManager alloc] init];
            locationManager.delegate=self;
            locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            locationManager.distanceFilter=100.0f;
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
            {
                [locationManager requestWhenInUseAuthorization];//请求允许在前台获取用户位置的授权（iOS8定位需要）
                //requestAlwaysAuthorization // 请求允许在前后台都能获取用户位置的授权
            }
        }
        [locationManager startUpdatingLocation];
    });
    return location;
}
#pragma mark - CoreLocation Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    location=currentLocation.coordinate;
   // location=[NSString stringWithFormat:@"%f,%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMessage;
    if ([error code] == kCLErrorDenied)
    {
        errorMessage = @"你的访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown)
    {
        errorMessage = @"无法定位到你的位置!";
    }
    NSLog(@"%@",errorMessage);
    [locationManager stopUpdatingLocation];
}
-(nonnull NSString*)language
{
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

#pragma Containers

static const NSString *iDeviceNameContainer[] = {
    
    [iPhone_1G]                 = @"iPhone 1G",
    
    [iPhone_3G]                 = @"iPhone 3G",
    
    [iPhone_3GS]                = @"iPhone 3GS",
    
    [iPhone_4]                  = @"iPhone 4",
    
    [iPhone_4_Verizon]          =@"Verizon iPhone 4",
    
    [iPhone_4S]                 = @"iPhone 4S",
    
    [iPhone_5_GSM]              = @"iPhone 5 (GSM)",
    
    [iPhone_5_CDMA]             = @"iPhone 5 (CDMA)",
    
    [iPhone_5C_GSM]             = @"iPhone 5C (GSM)",
    
    [iPhone_5C_GSM_CDMA]        =@"iPhone 5C (GSM+CDMA)",
    
    [iPhone_5S_GSM]             = @"iPhone 5S (GSM)",
    
    [iPhone_5S_GSM_CDMA]        =@"iPhone 5S (GSM+CDMA)",
    
    [iPhone_6]                  = @"iPhone 6",
    
    [iPhone_6_Plus]             = @"iPhone 6 Plus",
    
    [iPhone_6S]                 = @"iPhone 6S",
    
    [iPhone_6S_Plus]            = @"iPhone 6S Plus",
    
    [iPhone_SE]                 = @"iPhone SE",
    
    [Chinese_iPhone_7]          =@"国行/日版/港行 iPhone 7",
    
    [Chinese_iPhone_7_Plus]     =@"港行/国行 iPhone 7 Plus",
    
    [American_iPhone_7]         = @"美版/台版 iPhone 7",
    
    [American_iPhone_7_Plus]    =@"美版/台版 iPhone 7 Plus",
    
    [Chinese_iPhone_8]          = @"国行/日版 iPhone 8",
    
    [Chinese_iPhone_8_Plus]     =@"国行/日版 iPhone 8 Plus",
    
    [Chinese_iPhone_X]          = @"国行/日版 iPhone X",
    
    [Global_iPhone_8]           =@"美版(Global) iPhone 8",
    
    [Global_iPhone_8_Plus]      =@"美版(Global) iPhone 8 Plus",
    
    [Global_iPhone_X]           =@"美版(Global) iPhone X",
    
    
    
    [iPod_Touch_1G]             = @"iPod Touch 1G",
    
    [iPod_Touch_2G]             = @"iPod Touch 2G",
    
    [iPod_Touch_3G]             = @"iPod Touch 3G",
    
    [iPod_Touch_4G]             = @"iPod Touch 4G",
    
    [iPod_Touch_5Gen]           =@"iPod Touch 5(Gen)",
    
    [iPod_Touch_6G]             = @"iPod Touch 6G",
    
    
    [iUnknown]                  = @"Unknown"
    
};
@end
