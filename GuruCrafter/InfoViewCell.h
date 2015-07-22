//
//  InfoViewCell.h
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
