//
//  UserViewController.h
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsersTableViewController.h"

@interface UserViewController : UIViewController

@property (strong, nonatomic) UsersTableViewController *usController;

-(IBAction)touchUpButton:(UIButton*)sender;

@end
