//
//  GenderViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    MALE,
    FEMALE,
} GenderType;
@protocol GenderSelectionDelegate <NSObject>

-(void)didSelectGenderType:(GenderType)type;

@end

@interface GenderViewController : UIViewController

@property (weak, nonatomic) id<GenderSelectionDelegate> delegate;

@end
