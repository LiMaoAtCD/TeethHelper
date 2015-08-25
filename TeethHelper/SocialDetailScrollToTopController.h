//
//  SocialDetailScrollToTopController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/25.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollToTopDelegate <NSObject>

-(void)needScrollToTop;

@end

@interface SocialDetailScrollToTopController : UIViewController


@property (nonatomic, weak) id<ScrollToTopDelegate> delegate;
@end
