//
//  UserInfoController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "UserInfoController.h"
#import "InfoViewCell.h"
#import "DataSource.h"

@interface UserInfoController ()

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"User";
    
    //UIEdgeInsets insets = UIEdgeInsetsMake(40, 0, 0, 0);
    //[self.tableView setContentInset:insets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions -

-(IBAction)touchUpButton:(UIButton*)sender {
    
    if (sender.tag == 1) {

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    InfoViewCell *cell = (InfoViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString *firstName = cell.textField.text;
    
    
    indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    cell = (InfoViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString *lastName = cell.textField.text;
    
    
    indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    cell = (InfoViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSString *email = cell.textField.text;
    
        
    if (!self.user) {
        [[DataSource sharedApplication] addUserWithName:firstName lastName:lastName andEmail:email]; } else
        {
            self.user.firstName = firstName;
            self.user.lastName = lastName;
            self.user.email = email;
        }

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"Identifier";
    static NSString *buttons = @"OkCancel";
    
    if (indexPath.row != 3) {
        
        InfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[InfoViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"Username:";
            
            if (self.user) {
                cell.textField.text = self.user.firstName;
            }
            
        } else if (indexPath.row == 1) {
            
            cell.textLabel.text = @"LastName:";
            if (self.user) {
                cell.textField.text = self.user.lastName;
            }
            
        } else if (indexPath.row == 2) {
            
            cell.textLabel.text = @"Email:";
            if (self.user) {
                cell.textField.text = self.user.email;
            }
        }
        
        return cell;
        
    } else if (indexPath.row == 3) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buttons forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[InfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buttons];
        }
        
        return cell;
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
