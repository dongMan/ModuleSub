//
//  FWManagedObjectModel.m
//  puzzle
//
//  Created by ydkt-author on 14-1-26.
//  Copyright (c) 2014年 ydkt-company. All rights reserved.
//

#import "FWManagedObjectModel.h"

@implementation FWManagedObjectModel

static FWManagedObjectModel* _sharedManagedObjectModel = nil;

+(FWManagedObjectModel*)sharedManagedObjectModel
{
    
    @synchronized(self){
        if (_sharedManagedObjectModel == nil) {
            _sharedManagedObjectModel = [[self alloc] init];
        }
    }
    return  _sharedManagedObjectModel;
}

+(id) allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (_sharedManagedObjectModel == nil) {
            _sharedManagedObjectModel = [super allocWithZone:zone];
            return  _sharedManagedObjectModel;
        }
    }
    return nil;
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
-(NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    //得到数据库的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //CoreData是建立在SQLite之上的，数据库名称需与Xcdatamodel文件同名
    NSURL *storeUrl = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"YDModel.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error])
    {
        NSLog(@"%@,%@",error,[error userInfo]);
        
        persistentStoreCoordinator= nil;
    }
    
    return persistentStoreCoordinator;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator =[self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc]init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return managedObjectContext;
}
@end
