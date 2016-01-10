//
//  MeibaiChangeTwoCell.h
//  TeethHelper
//
//  Created by AlienLi on 16/1/10.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeibaiChangeTwoCell : UITableViewCell
@property (nonatomic, strong) UIButton *addProjectButton;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+(NSString*)identifier;


@end
