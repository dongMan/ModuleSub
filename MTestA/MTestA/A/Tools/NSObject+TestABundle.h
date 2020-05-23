//
//  NSObject+TestABundle.h
//  TestA
//
//  Created by 董雪娇 on 2020/5/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TestABundle)

@end


@interface UIImage (TestABundle)

+ (UIImage *)imageWithTestANamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
