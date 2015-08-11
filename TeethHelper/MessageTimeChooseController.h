//
//  MessageTimeChooseController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TimeSelectionDelegate <NSObject>

-(void)didSelectTime:(NSDate*)date;

@end

@interface MessageTimeChooseController : UIViewController

@property (weak, nonatomic) id<TimeSelectionDelegate> delegate;

@property (nonatomic, strong) NSString *currentDate;

@end
