//
//  DataSource.h
//  GuruCrafter
//
//  Created by  ZHEKA on 16.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@interface DataSource : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (DataSource*) sharedApplication;
- (void) generateUsers;
-(void) printAll;
- (void) deleteAllObjects;
- (User*) addUserWithName: (NSString*) name lastName: (NSString*) lastName andEmail: (NSString*) email;

@end
