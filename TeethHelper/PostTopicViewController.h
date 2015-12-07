//
//  PostTopicViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/23.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialRefreshDelegate.h"
//@protocol PostItemDelegate <NSObject>
//
//-(void)refreshTableView;

//@end

@interface PostTopicViewController : UIViewController

@property (nonatomic, weak) id<SocialRefreshDelegate> delegate;

@end
