//
//  UIImage+imageWithName.m
//  MBasis
//
//  Created by on 2019/8/23.
//  Copyright © 2019. All rights reserved.
//

#import "UIImage+imageWithName.h"

@implementation UIImage (imageWithName)
+ (UIImage *)imageWithName:(NSString *)name module:(NSString *)module selfclass:(id)vc{
    //拼接bundle
    NSString * bundleName = [NSString stringWithFormat:@"%@.bundle",module];
    NSString *Path = [[NSBundle bundleForClass:[vc class]].resourcePath
                      stringByAppendingPathComponent:bundleName];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:Path];
    if (resource_bundle) {
        UIImage *image = [UIImage imageNamed:name inBundle:resource_bundle compatibleWithTraitCollection:nil];
        return image;
    }else{
        return [UIImage imageNamed:name];
    }
    
}
@end
