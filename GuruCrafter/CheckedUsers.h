//
//  CheckedUsers.h
//  GuruCrafter
//
//  Created by  ZHEKA on 20.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "DataViewController.h"

@interface CheckedUsers : DataViewController

@property (strong, nonatomic) Course *course;

- (instancetype)initWithCourse : (Course*) course;

@end
