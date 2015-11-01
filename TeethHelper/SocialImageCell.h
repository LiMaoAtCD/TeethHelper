//
//  SocialImageCell.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/18.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cotentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentThreeImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *loveLabel;

@end
