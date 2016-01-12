//
//  AlienTimerView.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AlienTimerView.h"
#import "UIColor+HexRGB.h"
@implementation AlienTimerView

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
        self.lightGrayLayer2.strokeEnd = 0.0;
        
        [self.layer addSublayer:self.lightGrayLayer2];
        
        //时间
        
        self.timerLabel= [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 90, self.bounds.size.height / 2 - 40, 190, 80)];
        self.timerLabel.text = @"0'00\"";
        self.timerLabel.textAlignment = NSTextAlignmentCenter;
        self.timerLabel.textColor = [UIColor colorWithRed:99.0/255 green:181./255 blue:180./255 alpha:1.0];
        //        self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100.0];
        self.timerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:50.0];

        [self addSubview:self.timerLabel];
        
        //类型
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - 50, self.bounds.size.height / 2 - 65, 140, 30)];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.textColor = [UIColor colorWithRed:99.0/255 green:181./255 blue:180./255 alpha:1.0];
        //        self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100.0];
        self.typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
        self.typeLabel.text = @"美白倒计时";

        [self addSubview:self.typeLabel];
        
        UIImage *image = [UIImage imageNamed:@"icon_daojishi"];
        UIImageView *clock = [[UIImageView alloc] initWithImage:image];
        [self addSubview:clock];
        clock.frame = CGRectMake(self.bounds.size.width / 2 - 63, self.bounds.size.height / 2 - 67, 22, 25);
//        icon_clock
    }
    
    return self;
}

-(void)animateToSeconds:(NSInteger)seconds{
    CGFloat maxSecond = 600.0;
    
    if (seconds < maxSecond) {
        
        CGFloat rate =  (CGFloat)seconds / 600;
//        self.lightGrayLayer2.strokeStart = 0;
        self.lightGrayLayer2.strokeEnd = 1 - rate;

    }
    
}

static NSInteger maxSecond = 480;

-(void)countdownToSecond:(NSInteger)seconds ForMaxSecond:(MeiBaiTimerType)type{

    if ( type == MeiBaiTimerTypeGoing) {
        self.lightGrayLayer2.strokeEnd = 1.0;
        maxSecond = 8 * 60;
        self.typeLabel.text = @"美白倒计时";

    } else{
        self.lightGrayLayer2.strokeEnd = 1.0;
        maxSecond =  2 * 60;
        self.typeLabel.text = @"换胶倒计时";

    }
    if (seconds <= maxSecond) {
        CGFloat rate =  (CGFloat)seconds / maxSecond;
        self.lightGrayLayer2.strokeEnd = 1 - rate;
        
//        2.显示对应时间
        seconds = maxSecond - seconds;
        
        NSInteger minute = seconds / 60;
        NSInteger second = seconds  - minute * 60;
        NSString *theTime = [NSString stringWithFormat:@"%.1ld'%.2ld\"", minute, second];
        //    self.alienView.timerLabel.text = theTime;
        
        self.timerLabel.text = theTime;
    }
    
    
}


//-(void)animateArcFrom:(CGFloat)begin To:(CGFloat)End{
//    if (End >= 1.0 || End < 0.0) {
//        self.foreGroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:(self.bounds.size.width / 2) startAngle:-0.5 * M_PI endAngle: M_PI clockwise:YES];
//        [self setNeedsDisplay];
//    } else{
//        self.foreGroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:(self.bounds.size.width / 2) startAngle:-0.5 * M_PI endAngle: M_PI clockwise:YES];
//        
//        self.lightGrayLayer2.strokeStart = start;
//        self.lightGrayLayer2.strokeEnd = End;
//        
//        CABasicAnimation * swipe = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        swipe.duration = 1.0;
//        swipe.fromValue=[NSNumber numberWithDouble:begin];
//        swipe.toValue=  [NSNumber numberWithDouble:End];
//        swipe.fillMode = kCAFillModeForwards;
//        swipe.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        swipe.removedOnCompletion = NO;
//        [self.lightGrayLayer2 addAnimation:swipe forKey:@"strokeEnd animation"];
        
//    }
//}
@end
