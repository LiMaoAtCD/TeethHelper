//
//  ALienGrayView.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALienGrayView : UIView

@property (nonatomic, strong) UILabel *daysLabel;
@property (nonatomic, strong) UILabel *typeLabel;

-(instancetype)initWithDays:(NSInteger)days forType:(NSString*)type;

@end
