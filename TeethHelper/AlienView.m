//
//  AlienView.m
//  CircleViewDemo
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AlienView.h"
#import <Masonry.h>
#import "UIColor+HexRGB.h"
@interface AlienView()

@property (nonatomic, strong)  UIBezierPath *foreGroundPath;
@property (nonatomic, strong)  CAShapeLayer *lightGrayLayer2;


@end
@implementation AlienView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
    
        //灰底
        CAShapeLayer *lightGrayLayer = [CAShapeLayer layer];
        
        UIBezierPath *backPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:(self.bounds.size.width / 2) startAngle:0 endAngle:2 *M_PI clockwise:YES];
        
        lightGrayLayer.path = backPath.CGPath;
        lightGrayLayer.lineWidth = 4.0;
        lightGrayLayer.fillColor = [UIColor clearColor].CGColor;
        lightGrayLayer.strokeColor = [UIColor colorWithHex:@"f1f1f1"].CGColor;
        
        
        [self.layer addSublayer:lightGrayLayer];
        
        //进度
        self.lightGrayLayer2 = [CAShapeLayer layer];

        self.foreGroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:(self.bounds.size.width / 2) startAngle:-0.5 * M_PI endAngle: 1.5 * M_PI clockwise:YES];
        
        self.lightGrayLayer2.path = self.foreGroundPath.CGPath;
        self.lightGrayLayer2.lineWidth = 6.0;
        self.lightGrayLayer2.fillColor = [UIColor clearColor].CGColor;
        self.lightGrayLayer2.strokeColor = [UIColor colorWithRed:99.0/255 green:181./255 blue:180./255 alpha:1.0].CGColor;
        self.lightGrayLayer2.strokeStart = 0.0;
        self.lightGrayLayer2.strokeEnd = 1.0;
        
        [self.layer addSublayer:self.lightGrayLayer2];
        
        //天数
        
        self.dayLabel= [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 70 - 10, self.bounds.size.height / 2 - 40, 140, 80)];
        self.dayLabel.text = self.day;
        self.dayLabel.textAlignment = NSTextAlignmentCenter;
        self.dayLabel.textColor = [UIColor colorWithRed:99.0/255 green:181./255 blue:180./255 alpha:1.0];
//        self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100.0];
        self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:100.0];

        [self addSubview:self.dayLabel];
        
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake( 6.0 / 8 * self.bounds.size.width, self.bounds.size.height / 2 + 40 - 30, 50, 30)];
        dayLabel.text = @"天";
        dayLabel.textAlignment = NSTextAlignmentLeft;
        dayLabel.textColor = [UIColor colorWithRed:99.0/255 green:181./255 blue:180./255 alpha:1.0];
        dayLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        
        [self addSubview:dayLabel];

        
    }
    
    return self;
    
    
}

-(void)setDay:(NSString *)day{
    self.dayLabel.text = day;
}

-(void)animateArcTo:(CGFloat)strokeEnd{
    if (strokeEnd >= 1.0 || strokeEnd < 0.0) {
         self.foreGroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:(self.bounds.size.width / 2) startAngle:-0.5 * M_PI endAngle: M_PI clockwise:YES];
        [self setNeedsDisplay];
    } else{
        self.foreGroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:(self.bounds.size.width / 2) startAngle:-0.5 * M_PI endAngle: M_PI clockwise:YES];
        self.lightGrayLayer2.strokeEnd = strokeEnd;

        CABasicAnimation * swipe = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        swipe.duration = 1.0;
        swipe.fromValue=[NSNumber numberWithDouble:0];
        swipe.toValue=  [NSNumber numberWithDouble:strokeEnd];
        swipe.fillMode = kCAFillModeForwards;
        swipe.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        swipe.removedOnCompletion=NO;
        [self.lightGrayLayer2 addAnimation:swipe forKey:@"strokeEnd animation"];
        
    }
}



@end
