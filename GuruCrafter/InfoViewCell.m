//
//  InfoViewCell.m
//  GuruCrafter
//
//  Created by  ZHEKA on 17.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "InfoViewCell.h"

@implementation InfoViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
    
    NSString *text = textField.text;
    
    if ([self.textLabel.text isEqualToString:@"Email:"])  { textField.text = [text lowercaseString]; } else {
        
        textField.text = [text capitalizedString]; }
    
    [self resignFirstResponder];
}



@end
