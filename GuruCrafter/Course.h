//
//  Course.h
//  GuruCrafter
//
//  Created by  ZHEKA on 18.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Object.h"

@class Teacher, User;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *users;
@property (nonatomic, retain) NSSet *teachers;
@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

- (void)addTeachersObject:(Teacher *)value;
- (void)removeTeachersObject:(Teacher *)value;
- (void)addTeachers:(NSSet *)values;
- (void)removeTeachers:(NSSet *)values;

@end
