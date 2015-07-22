//
//  UserViewController.m
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "UserViewController.h"
#import "DataSource.h"

@interface UserViewController () <UITextFieldDelegate>

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(IBAction)touchUpButton:(UIButton*)sender {

    if (sender.tag == 1) {
            
        [[DataSource sharedApplication] addUserWithName:self.firstName.text lastName:self.lastName.text andEmail:self.email.text];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
