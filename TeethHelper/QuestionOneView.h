//
//  QuestionOneView.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Selected,
    Normal,
} OneViewSelectionType;

@interface QuestionOneView : UIView

-(instancetype)initWithLabel:(NSString *)AgeRange;

@property (nonatomic,strong) UILabel *rangeLabel;
@property (nonatomic,strong) UIImageView *selectedImageview;


-(void)didSelectionAtIndex:(OneViewSelectionType)type;

@end
