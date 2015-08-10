//
//  BirthDayViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BirthDaySelectionDelegate <NSObject>


-(void)didSelectedBirthDay:(NSString *)birthday;
@end

@interface BirthDayViewController : UIViewController

@property (weak, nonatomic) id<BirthDaySelectionDelegate>  delegate;

@end
