//
//  UserInfoController.h
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserInfoController : UITableViewController

-(IBAction)touchUpButton:(UIButton*)sender;

@property (weak, nonatomic) IBOutlet UITextField *email, *firstName, *lastName;
@property (strong, nonatomic) User *user;

@end
