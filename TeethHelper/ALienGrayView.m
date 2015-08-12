//
//  ALienGrayView.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ALienGrayView.h"

@implementation ALienGrayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithDays:(NSInteger)days forType:(NSString*)type{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.daysLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)days];
        self.daysLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.daysLabel];
        
        self.typeLabel = [[UILabel alloc]  initWithFrame:CGRectZero];
        self.typeLabel.textColor = [UIColor whiteColor];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.text = type;
        [self addSubview:self.typeLabel];
    }
    
    return self;
}



@end
