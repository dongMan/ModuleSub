//
//  FWEntity.m
//  puzzle
//
//  Created by ydkt-author on 14-1-26.
//  Copyright (c) 2014年 ydkt-company. All rights reserved.
//
#import "FWEntity.h"
#import "FWManagedObjectModel.h"

@implementation FWEntity

+(void) removeAll:(NSString*) entityName
{
    for (FWEntity *_object in [FWEntity objects:entityName predicate:nil sort:nil]) {
        
        [_object remove];
    }
    [[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext] save:nil];
}
+(NSArray*) objects:(NSString*) entityName
{
    return [FWEntity objects:entityName predicate:nil sort:nil];
}
+(NSArray*) objects:(NSString*) entityName predicate:(NSPredicate*)query sort:(NSArray*)sortDescriptors
{
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    if(query) [request setPredicate:query];

    if(sortDescriptors) [request setSortDescriptors:sortDescriptors];
    
    //NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"group.name" ascending:YES];
    //[NSArray arrayWithObjects:sort1,nil];
    //[NSPredicate predicateWithFormat:@"(URL == %@)", url];
    
    NSManagedObjectContext *context=[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext];
    if(context==nil) return nil;
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    if(entity==nil) return nil;
    
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *_objects = [context executeFetchRequest:request error:&error];
    return _objects;
}
-(id)initWithName:(NSString*) name
{
    entityName=name;
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext]];
}
-(BOOL) save
{
    NSError *error = nil;
    if (![[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext] save:&error])
    {
        NSLog(@"%@,%@",error,[error userInfo]);
        return NO;
    }
    return YES;
}
-(void)undoManager
{
    NSUndoManager *anUndoManager = [[NSUndoManager  alloc] init];
    [[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext] setUndoManager:anUndoManager];

}

-(void) undo
{
    [[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext] undo];
}
-(void)remove
{
    [[[FWManagedObjectModel sharedManagedObjectModel] managedObjectContext] deleteObject:self];
    [self save];
}

/*
 NSError *error;
 if (managedObjectContext != nil) {
 //hasChanges方法是检查是否有未保存的上下文更改，如果有，则执行save方法保存上下文
 if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
 NSLog(@"Error: %@,%@",error,[error userInfo]);
 abort();
 }
 }*/
@end
