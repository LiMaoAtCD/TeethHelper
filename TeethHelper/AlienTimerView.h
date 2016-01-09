//
//  AlienTimerView.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MeiBaiTimerTypeGoing,
    MeiBaiTimerTypePause
} MeiBaiTimerType;

@interface AlienTimerView : UIView

@property (nonatomic, strong)  UIBezierPath *foreGroundPath;
@property (nonatomic, strong)  CAShapeLayer *lightGrayLayer2;
@property (nonatomic, strong)  UILabel *timerLabel;
@property (nonatomic, strong)  UILabel *typeLabel;




-(instancetype)initWithFrame:(CGRect)frame;
-(void)animateToSeconds:(NSInteger)seconds;
/**
 *  倒计时八分钟
 */
-(void)countdownToSecond:(NSInteger)seconds ForMaxSecond:(MeiBaiTimerType)type;

@end
