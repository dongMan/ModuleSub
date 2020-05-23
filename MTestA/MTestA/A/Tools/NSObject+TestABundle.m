//
//  NSObject+TestABundle.m
//  TestA
//
//  Created by 董雪娇 on 2020/5/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//


#import "NSObject+TestABundle.h"

#import "UIImage+imageWithName.h"

#import "TestAOCViewController.h"

#if PODTESTA==1
#import <TestA/TestA-Swift.h>
#endif

@implementation NSObject (TestABundle)

@end


@implementation UIImage (TestABundle)

+ (UIImage *)imageWithTestANamed:(NSString *)name {
    return [UIImage imageWithName:name module:@"MTestA" selfclass:[TestAOCViewController class]];
}

@end

