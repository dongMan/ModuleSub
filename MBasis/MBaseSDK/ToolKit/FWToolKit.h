//
//  FWToolKit.h
//  fwang
//
//  Created by ydkt-author on 15/12/16.
//  Copyright © 2015年 ydkt-company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWToolKit : NSObject

+ (NSString *)MD5:(NSString *)source;
+ (NSString *)GUID;

+(NSData *)unZipData:(NSData *)compressed;
+ (NSData *)zipData:(NSData *)data;

+(NSString*) objectToJSONString:(NSObject*) object;
+(NSData*) objectToJSONData:(NSObject*) object;
+(id) JSONDataToObject:(NSData*) data;
+(id) JSONStringToObject:(NSString*) str;
+ (NSString *) stringWithDict:(NSDictionary *) dict;
+(NSString *)encodeToPercentEscapeString:(NSString *) input;
+(NSString *)decodeFromPercentEscapeString:(NSString *) input;

+(NSString*)data2HEX:(NSData*)data;
+(NSData*)hex2Data:(NSString*)str;

+(NSString *)timeFormate:(NSTimeInterval)time;

+(UIImage*)scaleToSize:(CGSize)size byImage:(UIImage*)__image;

+ (NSString*) base64Encode:(NSData *)data;
+(NSData*) base64Decode:(NSString *)string;

+(NSString *)filterHTML:(NSString *)html;
+(NSString *)decodeString:(NSString*)encodedString;

+ (long long) fileSizeAtPath:(NSString*) filePath;
+(float ) folderSizeAtPath:(NSString*) folderPath;
+(void) cachesClean:(NSString*)downloadBundle;

+(float)heightOfText:(NSString*)content width:(float)width fontSize:(float)fontSize;
+ (NSString*)transfromString2:(NSString*)originalString key2fileDic:(NSDictionary*)key2fileDic;
+ (NSString*)chatString:(NSString*)originalStr text2keyDic:(NSDictionary*)_text2keyDic;

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+ (void)showNoticeText:(NSString *)showText;
//MARK:showY 0 默认为屏幕中心
+ (void)showNoticeText:(NSString *)showText showY:(CGFloat)showY afterDelay:(CGFloat)showTime;
//表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (BOOL)hasEmoji:(NSString*)string;
+ (NSString *)disable_emoji:(NSString *)text;
+ (BOOL)isNineKeyBoard:(NSString *)string;
+ (NSInteger)compareVersionV1:(NSString *)v1 toV2:(NSString *)v2;

//密码
+ (BOOL)validatePassword:(NSString *)passWord;
@end
