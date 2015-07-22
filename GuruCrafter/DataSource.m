//
//  DataSource.m
//  GuruCrafter
//
//  Created by  ZHEKA on 16.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "DataSource.h"
#import "Course.h"
#import "Teacher.h"

@implementation DataSource

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};


static NSString* courses[] = {
    
    @"iOS", @"Java", @"HTML"
};

static NSString* userEmails[] = {
    
    @"vasya-pupkin@mail.ru", @"ey2011@list.ru", @"sabino4ka1995@mail.ru", @"email@mail.ru", @"sjndja@gmail.com",

};

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DataSource*) sharedApplication {
    
    static DataSource *dataSource = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSource = [[DataSource alloc] init];
    });
    
    return dataSource;
}

- (void) generateUsers {
    
    [self deleteAllObjects];
    
    Course *firstCourse = [self addRandomCourse];
    Course *secondCourse = [self addRandomCourse];
    Course *thirdCourse = [self addRandomCourse];
    
    for (int i = 0; i < 10; i++) {
        User *user = [self addRandomUser];
        [user addCoursesObject:firstCourse];
    }
    for (int i = 0; i < 10; i++) {
        User *user = [self addRandomUser];
        [user addCoursesObject:secondCourse];
    }
    for (int i = 0; i < 10; i++) {
        User *user = [self addRandomUser];
        [user addCoursesObject:thirdCourse];
    }
    
    [self.managedObjectContext save:nil];
}

- (void) deleteUser : (NSManagedObject*) user {

    [self.managedObjectContext deleteObject: user];
}

- (Teacher*) addRandomTeacher {
    
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
    teacher.firstName = firstNames[arc4random_uniform(50)];
    teacher.lastName = lastNames[arc4random_uniform(50)];
    
    [self.managedObjectContext save:nil];
    
    return teacher;
}

- (Course*) addRandomCourse {

    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext: self.managedObjectContext];
    
    [course addTeachersObject:[self addRandomTeacher]];
    
    course.name = courses[arc4random_uniform(3)];
    
    [self.managedObjectContext save:nil];
    
    return course;
}

- (User*) addRandomUser {
    
    NSString *firstName = firstNames[arc4random_uniform(50)];
    NSString *lastName = lastNames[arc4random_uniform(50)];
    NSString *email = userEmails[arc4random_uniform(5)];
    
    User *user = [self addUserWithName:firstName lastName:lastName andEmail:email];
    
    return user;
}

- (User*) addUserWithName: (NSString*) name lastName: (NSString*) lastName andEmail: (NSString*) email {
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    user.firstName = name;
    user.lastName = lastName;
    user.email = email;
    
    [self.managedObjectContext save:nil];
    
    return user;
}


-(void) printAll {
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Object" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    [self printArray:array];
    
}

- (void) deleteAllObjects {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Object" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *object in array) {
        [self.managedObjectContext deleteObject:object];
    }
    
    [self.managedObjectContext save:nil];
}

- (void) printArray : (NSArray*) array {
    
    for (NSManagedObject *object in array) {
        
        if ([object isKindOfClass:[User class]]) {
         
            NSLog(@"%@ %@ EMAIL: %@", [object valueForKey:@"firstName"],[object valueForKey:@"lastName"], [object valueForKey:@"email"]); 
        } else if ([object isKindOfClass:[Course class]]) {
            
            NSLog(@"Course NAME: %@ COUNT: %ld", [object valueForKey:@"name"], [[object valueForKeyPath:@"users.@count"] integerValue]);
        } else if ([object isKindOfClass:[Teacher class]]) {
    
            NSLog(@"TEACHER: %@ %@ COUNT COURSES: %ld", [object valueForKey:@"firstName"],[object valueForKey:@"lastName"],[[object valueForKeyPath:@"courses.@count"] integerValue]);
        }
    }
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.bignerdranch.GuruCrafter" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GuruCrafter" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GuruCrafter.sqlite"];
    NSError *error = nil;

    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];;
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
