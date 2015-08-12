//
//  AlienView.h
//  CircleViewDemo
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlienView : UIView

@property (nonatomic, strong) NSString *day;

@property (nonatomic, strong) UILabel *dayLabel;

-(instancetype)initWithFrame:(CGRect)frame;



-(void)animateArcTo:(CGFloat)angle;

@end
