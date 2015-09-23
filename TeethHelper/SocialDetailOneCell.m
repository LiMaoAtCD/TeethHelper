//
//  SocialDetailOneCell.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/24.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialDetailOneCell.h"

@implementation SocialDetailOneCell

- (void)awakeFromNib {
    // Initialization code
    
    self.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
