//
//  ALienGrayView.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ALienGrayView.h"
#import <Masonry.h>
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
        self.daysLabel.font = [UIFont systemFontOfSize:40];
        [self addSubview:self.daysLabel];
        
        self.typeLabel = [[UILabel alloc]  initWithFrame:CGRectZero];
        self.typeLabel.textColor = [UIColor whiteColor];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.text = type;
        [self addSubview:self.typeLabel];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.daysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(self.mas_height).multipliedBy(2./3);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.daysLabel.mas_bottomMargin).offset(5);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(self.mas_height).multipliedBy(1./3);
    }];
}

@end
