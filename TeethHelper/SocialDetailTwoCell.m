//
//  SocialDetailTwoCell.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/24.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialDetailTwoCell.h"

@implementation SocialDetailTwoCell

- (void)awakeFromNib {
    // Initialization code
    self.contentOneImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.contentTwoImageView.contentMode = UIViewContentModeScaleAspectFit;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
