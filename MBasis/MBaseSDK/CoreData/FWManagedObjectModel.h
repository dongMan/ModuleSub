//
//  FWManagedObjectModel.h
//  puzzle
//
//  Created by ydkt-author on 14-1-26.
//  Copyright (c) 2014年 ydkt-company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FWManagedObjectModel : NSObject
{
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectContext *managedObjectContext;
   
}
-(NSManagedObjectContext *)managedObjectContext;
+(FWManagedObjectModel*)sharedManagedObjectModel;
@end
