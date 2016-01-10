//
//  MeibaiChangeOneCell.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/10.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "MeibaiChangeOneCell.h"
#import <Masonry.h>
#import "RS_SliderView.h"
#import "Utils.h"
@implementation MeibaiChangeOneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _meibaiLabel = [[UILabel alloc] init];
    _meibaiLabel.text = @"美白计划";
    [self addSubview:_meibaiLabel];
    
    [_meibaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_leftMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    _keepLabel = [[UILabel alloc] init];
    _keepLabel.text = @"保持计划";
    _keepLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_keepLabel];
    [_keepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_rightMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];

    self.sliderView = [[RS_SliderView alloc] initWithFrame:CGRectMake(0, 0, 100, 30) andOrientation:Horizontal];
    [self.sliderView setColorsForBackground:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]
                                 foreground:[UIColor colorWithRed:68./255.0 green:164.0/255.0 blue:167.0/255.0 alpha:1.0]
                                     handle:[UIColor colorWithRed:136.0/255.0 green:255.0/255.0 blue:254.0/255.0 alpha:1.0]
                                     border:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]];
    [self addSubview:self.sliderView];
    self.sliderView.userInteractionEnabled = NO;
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_meibaiLabel.mas_right).offset(10);
        make.right.equalTo(_keepLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@30);
    }];
//    [self.sliderView setValue:0.0 withAnimation:NO completion:nil];
    
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_isZero) {
        [self.sliderView setValue:0.0 withAnimation:NO completion:nil];
        _keepLabel.textColor = [UIColor lightGrayColor];
        _meibaiLabel.textColor = [Utils commonColor];
        
    } else{
        [self.sliderView setValue:1.0 withAnimation:NO completion:nil];
        _keepLabel.textColor = [Utils commonColor];
        _meibaiLabel.textColor = [UIColor lightGrayColor];
    }

}

-(void)setvalueTozeroOrOne:(BOOL)isZero{
    self.isZero = isZero;
    if (isZero) {
        [self.sliderView setValue:0.0 withAnimation:NO completion:nil];
        _keepLabel.textColor = [UIColor lightGrayColor];
        _meibaiLabel.textColor = [Utils commonColor];
        
    } else{
        [self.sliderView setValue:1.0 withAnimation:NO completion:nil];
        _keepLabel.textColor = [Utils commonColor];
        _meibaiLabel.textColor = [UIColor lightGrayColor];
    }

}

+(NSString*)identifier{
    return @"MeibaiChangeOneCell";
}
@end
