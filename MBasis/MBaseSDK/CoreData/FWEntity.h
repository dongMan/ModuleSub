//
//  FWEntity.h
//  puzzle
//
//  Created by ydkt-author on 14-1-26.
//  Copyright (c) 2014年 ydkt-company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FWEntity: NSManagedObject {
    NSString * entityName;
}

-(id)initWithName:(NSString*) name;

-(void)undoManager;
-(void)undo;
-(void)remove;
-(BOOL)save;
+(NSArray*) objects:(NSString*) name;
+(NSArray*) objects:(NSString*) entityName predicate:(NSPredicate*)query sort:(NSArray*)sortDescriptors;
+(void) removeAll:(NSString*) entityName;

@end
