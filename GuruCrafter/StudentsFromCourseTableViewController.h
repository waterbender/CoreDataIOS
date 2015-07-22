//
//  CourseTableViewController.h
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataViewController.h"
#import "Course.h"

@interface StudentsFromCourseTableViewController : DataViewController
@property (strong, nonatomic) Course *course;
@end
