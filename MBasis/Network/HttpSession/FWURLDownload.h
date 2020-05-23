//
//  FWURLDownload.h
//  fwang
//
//  Created by ydkt-author on 15/12/30.
//  Copyright © 2015年 ydkt-company. All rights reserved.
//
#define kFWDownloadBundle @"ydkt-company.download"

#import <Foundation/Foundation.h>
typedef void (^FWURLDownloadCallback)(NSDictionary*);
@interface FWURLDownload : NSObject

-(void)download:(NSDictionary*) options completed:(FWURLDownloadCallback) callback;
@end
