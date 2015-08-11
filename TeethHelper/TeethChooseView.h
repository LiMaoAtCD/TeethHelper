//
//  TeethChooseView.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    Selected,
    Normal,
} ColorType;

@interface TeethChooseView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, strong) UIImageView *bgImageView;



-(instancetype)initWithTitle:(NSString *)title;

-(void)didCHangeColorType:(ColorType)type;

@end
