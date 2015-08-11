//
//  AvatarCell.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AvatarCell.h"

@implementation AvatarCell

- (void)awakeFromNib {
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAvatar:) name:@"updateAvatar" object:nil];
}
-(void)updateAvatar:(NSNotification *)notification{
    
    NSDictionary *imageDic = [notification object];
    self.avatarImageView.image = imageDic[@"avatar"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
