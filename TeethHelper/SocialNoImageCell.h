//
//  SocialNoImageCell.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/18.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialNoImageCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@end
