//
//  QuestionOneView.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionOneView.h"
#import <Masonry.h>
#import "Utils.h"
@implementation QuestionOneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithLabel:(NSString *)AgeRange{
    self = [super init];
    if (self) {
        self.selectedImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nocheck"]];
        [self addSubview:self.selectedImageview];

        self.rangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.rangeLabel.text = AgeRange;
        self.rangeLabel.textColor = [UIColor lightGrayColor];
//        self.rangeLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:self.rangeLabel];
        
        [self.selectedImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.width.equalTo(@24);
            make.height.equalTo(@24);
            make.left.equalTo(self.mas_left).offset(10);
        }];
        
        [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectedImageview.mas_right).offset(8);
            make.centerY.equalTo(self.selectedImageview.mas_centerY);
            make.right.equalTo(self.mas_right).offset(0);
            make.height.equalTo(@30);
        }];
    }
    
    return self;
}
-(void)didSelectionAtIndex:(OneViewSelectionType)type{
    
    if (type == Selected) {
        self.selectedImageview.image = [UIImage imageNamed:@"icon_check"];
        self.rangeLabel.textColor = [Utils commonColor];
    } else{
        self.rangeLabel.textColor = [UIColor lightGrayColor];
        self.selectedImageview.image = [UIImage imageNamed:@"icon_nocheck"];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

}
@end
