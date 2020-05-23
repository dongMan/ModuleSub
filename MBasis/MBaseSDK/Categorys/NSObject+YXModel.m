//
//  NSObject+MLModel.m
//  ydkt-product-name
//
//  Created by ydkt-author on 2017/10/13.
//  Copyright © 2017年 ydkt-company. All rights reserved.
//

#import "NSObject+YXModel.h"
#import <LKDBHelper/LKDBHelper.h>

@implementation NSObject (YXModel)

+ (LKDBHelper *)getUsingLKDBHelper {
    ///ios8 能获取系统类的属性了  所以没有办法判断属性数量来区分自定义类和系统类
    ///可能系统类的存取会不正确
    static LKDBHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[LKDBHelper alloc] initWithDBName:@"yuoduoketang"];
    });
    return helper;
}

+ (BOOL)deleteWithWhere:(NSString *) sql {
    return [[self getUsingLKDBHelper] deleteWithClass:self where:sql];
}

@end

@implementation LKDBHelper (MLModel)

+ (LKDBHelper *)getUsingLKDBHelper {
    return [[LKDBHelper alloc] initWithDBName:@"yuoduoketang"];
}

@end
