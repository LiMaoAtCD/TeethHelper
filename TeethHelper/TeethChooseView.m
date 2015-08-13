//
//  TeethChooseView.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "TeethChooseView.h"
#import <Masonry.h>
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
        //背景图片
        self.bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
        self.bgImageView.image = [UIImage imageNamed:@"box_option_bg"];
        
        [self addSubview:self.bgImageView];
        //check
        self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.selectedImageView.image = [UIImage imageNamed:@"icon_check_1"];
        [self addSubview:self.selectedImageView];
        
        //Label
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor lightGrayColor];

        [self addSubview:self.titleLabel];
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@20);
            make.width.equalTo(@200);
        }];
       
        
        
        [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(0);

            make.right.equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
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
