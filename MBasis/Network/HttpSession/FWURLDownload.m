//
//  FWURLDownload.m
//  FWSDK
//
//  Created by ydkt-author on 15/12/30.
//  Copyright © 2015年 ydkt-company. All rights reserved.
//

#import "FWURLDownload.h"
#import "FWToolKit.h"

@interface FWURLDownload()
{
    //NSMutableArray*_downloads;
    NSString*downloadBundle;
}
@end
@implementation FWURLDownload
-(id)init
{
    self=[super init];
    if(self)
    {
        //_downloads=[[NSMutableArray alloc] init];
        NSError* error;
        NSString* documentPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        downloadBundle=[documentPath stringByAppendingPathComponent:kFWDownloadBundle];
        BOOL isDir;
        if(![[NSFileManager defaultManager] fileExistsAtPath:downloadBundle isDirectory:&isDir] ) {
            [[NSFileManager defaultManager] createDirectoryAtPath:downloadBundle withIntermediateDirectories:YES attributes:nil error:&error];
        }
    }
    return self;
}
-(void)download:(NSDictionary*) options completed:(FWURLDownloadCallback) callback
{
    BOOL isDir;
    NSError* error=nil;
    if(![[NSFileManager defaultManager] fileExistsAtPath:downloadBundle isDirectory:&isDir] ) {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadBundle withIntermediateDirectories:YES attributes:nil error:&error];
    }
    __block NSMutableDictionary* result=[[NSMutableDictionary alloc] initWithDictionary:options];
    dispatch_group_t group = dispatch_group_create();
    for(NSString* url in [options allKeys])
    {
        NSString* fileName=[options objectForKey:url];
        if([fileName hasSuffix:@"/"])
        {
            NSArray*filePaths=[fileName componentsSeparatedByString:@"/"];
            NSString*_filePath=downloadBundle;
            for(int i=0;i<[filePaths count]-1;i++)
            {
                NSString* path=filePaths[i];
                _filePath= [_filePath stringByAppendingPathComponent:path];
                BOOL isDir;
                NSError* error=nil;
                if(![[NSFileManager defaultManager] fileExistsAtPath:_filePath isDirectory:&isDir] ) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:_filePath withIntermediateDirectories:YES attributes:nil error:&error];
                }
            }
            fileName=[fileName stringByAppendingPathComponent:[FWToolKit MD5:url]];
        }
        if(fileName.length==0)
        {
            fileName=[fileName stringByAppendingPathComponent:[FWToolKit MD5:url]];
        }
        fileName=[downloadBundle stringByAppendingPathComponent:fileName];
        if([[NSFileManager defaultManager] fileExistsAtPath:fileName] ) {
            result[url]=fileName;
            continue;
        }
        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
            
            NSError *error;
            NSHTTPURLResponse *response;
            NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
            NSData* fileData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
            if(error==nil && response.statusCode==200)
            {
                if(![[NSFileManager defaultManager] createFileAtPath:fileName contents:fileData attributes:nil])
                {
                    [[NSFileManager defaultManager]  removeItemAtPath:fileName error:&error];
                    result[url]=@"";
                }
                else
                {
                    result[url]=fileName;
                }
            }
            else
            {
                result[url]=@"";
               // NSLog(@"Url=%@error:%@",url,[error domain]);
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        
        callback(result);
    });
}
@end
