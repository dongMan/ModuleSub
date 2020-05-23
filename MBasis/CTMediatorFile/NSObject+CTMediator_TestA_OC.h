//
//  NSObject+CTMediator_TestA_OC.h
//  TestA
//
//  Created by 董雪娇 on 2020/3/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (CTMediator_TestA_OC)
- (UIViewController *)ModuleA_showTargetOC_ActionOC:(void(^)(NSString *result))callback;

- (UIViewController *)ModuleA_showTargetOC_ActionSwift:(void(^)(NSString *result))callback;

- (UIViewController *)ModuleA_showTargetSwift_ActionOC:(void(^)(NSString *result))callback;

- (UIViewController *)ModuleA_showTargetSwift_ActionSwift:(void(^)(NSString *result))callback;
@end

NS_ASSUME_NONNULL_END
