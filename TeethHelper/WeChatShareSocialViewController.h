//
//  WeChatShareSocialViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/9/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareToSocialDelegate <NSObject>

-(void)didShareToSocialClicked;

@end

@interface WeChatShareSocialViewController : UIViewController

@property (nonatomic, weak) id<ShareToSocialDelegate> delegate;

@end
