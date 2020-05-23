//
//  NSObject+TestBBundle.m
//  TestB
//
//  Created by 董雪娇 on 2020/5/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import "NSObject+TestBBundle.h"

#import "UIImage+imageWithName.h"

#import "TestBOCViewController.h"

//#if PODTESTB==1
//#import <TestB/TestB-Swift.h>
//#endif

@implementation NSObject (TestBBundle)

@end

@implementation UIImage (TestBBundle)

+ (UIImage *)imageWithTestBNamed:(NSString *)name {
    return [UIImage imageWithName:name module:@"MTestB" selfclass:[TestBOCViewController class]];
}

@end

