//
//  AlienTimerView.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlienTimerView : UIView

@property (nonatomic, strong)  UIBezierPath *foreGroundPath;
@property (nonatomic, strong)  CAShapeLayer *lightGrayLayer2;
@property (nonatomic, strong)  UILabel *timerLabel;



-(instancetype)initWithFrame:(CGRect)frame;



-(void)animateArcTo:(CGFloat)angle;

@end
