//
//  NSObject+CTMediator_TestA_OC.m
//  TestA
//
//  Created by 董雪娇 on 2020/3/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import "NSObject+CTMediator_TestA_OC.h"

@implementation CTMediator (CTMediator_TestA_OC)
- (UIViewController *)ModuleA_showTargetOC_ActionOC:(void(^)(NSString *result))callback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    /*
     1. 字符串 是类名 Target_xxx.h 中的 xxx 部分
     2. 字符串是 Target_xxx.h 中 定义的 Action_xxxx 函数名的 xxxx 部分
     */
    return [self performTarget:@"OCTestA" action:@"OCTest2ViewController" params:params shouldCacheTarget:NO];
}

- (UIViewController *)ModuleA_showTargetOC_ActionSwift:(void(^)(NSString *result))callback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    /*
     1. 字符串 是类名 Target_xxx.h 中的 xxx 部分
     2. 字符串是 Target_xxx.h 中 定义的 Action_xxxx 函数名的 xxxx 部分
     */
    return [self performTarget:@"OCTestA" action:@"SwiftTest2ViewController" params:params shouldCacheTarget:NO];
}

- (UIViewController *)ModuleA_showTargetSwift_ActionOC:(void(^)(NSString *result))callback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    //指向swift类，必须指定对应模块名称
    params[kCTMediatorParamsKeySwiftTargetModuleName] = @"MTestA";

    /*
     1. 字符串 是类名 Target_xxx.h 中的 xxx 部分
     2. 字符串是 Target_xxx.h 中 定义的 Action_xxxx 函数名的 xxxx 部分
     */
    id obj = [self performTarget:@"TestA" action:@"OCTest2_ViewController" params:params shouldCacheTarget:NO];
    return obj;
}

- (UIViewController *)ModuleA_showTargetSwift_ActionSwift:(void(^)(NSString *result))callback {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    params[@"vcName"] = @"Test1";

    params[kCTMediatorParamsKeySwiftTargetModuleName] = @"MTestA";

    /*
     1. 字符串 是类名 Target_xxx.h 中的 xxx 部分
     2. 字符串是 Target_xxx.h 中 定义的 Action_xxxx 函数名的 xxxx 部分
     */
    
    id obj = [self performTarget:@"TestA" action:@"SwiftTest1_ViewController" params:params shouldCacheTarget:NO];
    return obj;
    
}


@end
