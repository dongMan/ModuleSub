//
//  Target_TestA.m
//  TestA
//
//  Created by 董雪娇 on 2020/3/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import "Target_OCTestA.h"
#import "TestOC1ViewController.h"
#import "TestOC2ViewController.h"

#if PODTESTA==1
#import <MTestA/MTestA-Swift.h>
#else
//#import "MTestA-Swift.h"
#endif

@implementation Target_OCTestA
- (UIViewController *)Action_OCTest2ViewController:(NSDictionary *)params {
    TestOC2ViewController *testAVC = [[TestOC2ViewController alloc] init];
    if ([testAVC isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        
        testAVC.test2CompleteHandler = ^(NSString * _Nonnull text) {
            typedef void (^CallbackType)(NSString *);
            CallbackType callback = params[@"callback"];
            if (callback) {
                callback(text);
            }
        };
        return testAVC;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        NSLog(@"%@ 未能实例化页面", NSStringFromSelector(_cmd));
        return nil;
    }
}

- (UIViewController *)Action_SwiftTest2ViewController:(NSDictionary *)params {
    NSLog(@"%@ 未能实例化页面", NSStringFromSelector(_cmd));
    return nil;
//    Test2ViewController *testAVC = [[Test2ViewController alloc] init];
//    if ([testAVC isKindOfClass:[UIViewController class]]) {
//        // view controller 交付出去之后，可以由外界选择是push还是present
//        testAVC.test2Block = ^(NSString * _Nonnull test) {
//            typedef void (^CallbackType)(NSString *);
//            CallbackType callback = params[@"callback"];
//            callback(test);
//        };
//        return testAVC;
//    } else {
//        // 这里处理异常场景，具体如何处理取决于产品
//        NSLog(@"%@ 未能实例化页面", NSStringFromSelector(_cmd));
//        return nil;
//    }
}
@end
