//
//  GuruCrafter.h
//  GuruCrafter
//
//  Created by  ZHEKA on 16.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Object.h"

@class User;

@interface GuruCrafter : NSManagedObject

@property (nonatomic, retain) NSSet *users;
@end

@interface GuruCrafter (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
