//
//  MeibaiChangeOneCell.h
//  TeethHelper
//
//  Created by AlienLi on 16/1/10.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class RS_SliderView;
#import "RS_SliderView.h"
@interface MeibaiChangeOneCell : UITableViewCell<RSliderViewDelegate>

@property( nonatomic, strong) RS_SliderView *sliderView;
@property( nonatomic, strong) UILabel *keepLabel;
@property( nonatomic, strong) UILabel *meibaiLabel;
@property( nonatomic, assign) BOOL isZero;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+(NSString*)identifier;

-(void)setvalueTozeroOrOne:(BOOL)isZero;


@end
