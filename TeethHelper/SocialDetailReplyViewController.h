//
//  SocialDetailReplyViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/25.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SocialLikeAndCommentDelegate <NSObject>

-(void)didClickLike;

-(void)didCommentPressed;

@end


@interface SocialDetailReplyViewController : UIViewController

@property (nonatomic, weak) id<SocialLikeAndCommentDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *likeView;

@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;


@property (weak, nonatomic) IBOutlet UIView *replyView;

@end
