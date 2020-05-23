//
//  UIImage+imageWithName.h
//  MBasis
//
//  Created by on 2019/8/23.
//  Copyright © 2019. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (imageWithName)

+ (UIImage *)imageWithName:(NSString *)name module:(NSString *)module selfclass:(id)vc;

@end

NS_ASSUME_NONNULL_END
