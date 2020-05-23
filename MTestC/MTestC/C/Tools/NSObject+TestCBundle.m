//
//  NSObject+TestCBundle.m
//  TestC
//
//  Created by 董雪娇 on 2020/5/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import "NSObject+TestCBundle.h"

#import "UIImage+imageWithName.h"

#import "TestCOCViewController.h"

#if PODTESTC==1
#import <TestC/TestC-Swift.h>
#else
//#import "TestC-Swift.h"
#endif

@implementation NSObject (TestCBundle)

@end

@implementation UIImage (TestCBundle)

+ (UIImage *)imageWithTestCNamed:(NSString *)name {
    return [UIImage imageWithName:name module:@"MTestC" selfclass:[TestCOCViewController class]];
}

@end

