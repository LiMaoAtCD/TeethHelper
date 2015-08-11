//
//  TeethChooseView.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "TeethChooseView.h"

@implementation TeethChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor lightGrayColor];

//        self.titleLabel.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        
        [self addSubview:self.titleLabel];
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
        self.bgImageView.image = [UIImage imageNamed:@""];
        [self addSubview:self.bgImageView];
        
        self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 40, 40)];
        self.bgImageView.image = [UIImage imageNamed:@""];
        [self addSubview:self.selectedImageView];
        
        
    }
    
    return self;
}

-(void)didCHangeColorType:(ColorType)type{
    if (type == Selected) {
        self.titleLabel.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        self.selectedImageView.hidden = NO;
    } else{
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.selectedImageView.hidden = YES;

    }
    [self setNeedsDisplay];
}

@end
