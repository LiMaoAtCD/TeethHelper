//
//  MeibaiChangeTwoCell.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/10.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "MeibaiChangeTwoCell.h"
#import <Masonry.h>
#import "Utils.h"
@implementation MeibaiChangeTwoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.addProjectButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.addProjectButton setTitle:@"新增疗程" forState:UIControlStateNormal];
    [self addSubview:self.addProjectButton];
    
    [self.addProjectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.right.equalTo(self).offset(-50);
        make.height.equalTo(@45);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    return self;
}
+(NSString*)identifier{
    return @"MeibaiChangeTwoCell";
}

@end
