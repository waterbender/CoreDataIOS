//
//  UserEnabledDissableCellTableViewCell.m
//  GuruCrafter
//
//  Created by  ZHEKA on 18.07.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "UserEnabledDissableCellTableViewCell.h"

@implementation UserEnabledDissableCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPicture:(UIImage *)picture {
    
    _picture = picture;
    
    CGPoint point = CGPointMake(self.bounds.size.width, self.bounds.size.height / 2);
    CGRect rect = CGRectMake(point.x, point.y - 20, 30, 30);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:picture];
    
    imageView.frame = rect;
    
    self.imView = imageView;
    
    [self addSubview:imageView];
}

@end
