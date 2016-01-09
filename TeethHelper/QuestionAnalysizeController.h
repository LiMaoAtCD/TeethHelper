//
//  QuestionAnalysizeController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Standard,
    Gentle,
    Enhance,
    Doctor
} TeethProjectType;

@interface QuestionAnalysizeController : UIViewController

@property (nonatomic, assign) TeethProjectType type;

@end
