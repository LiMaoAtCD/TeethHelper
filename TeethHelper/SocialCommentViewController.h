//
//  SocialCommentViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/25.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentDelegate<NSObject>

-(void)postComment:(NSString*)comment;

@end

@interface SocialCommentViewController : UIViewController

@property (nonatomic, weak) id<CommentDelegate> delegate;


@end
