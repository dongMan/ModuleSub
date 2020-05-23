//
//  TestOC2ViewController.h
//  TestA
//
//  Created by 董雪娇 on 2020/3/6.
//  Copyright © 2020 董雪娇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestOC2ViewController : UIViewController
@property (nonatomic, copy) void (^test2CompleteHandler)(NSString *text);

@end

NS_ASSUME_NONNULL_END
