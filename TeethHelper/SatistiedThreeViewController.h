//
//  SatistiedThreeViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/9/17.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SatistiedThreeViewController : UIViewController

@property (nonatomic, assign) NSInteger firstpage_answer1;
@property (nonatomic, assign) NSInteger firstpage_answer2;

@property (nonatomic, assign) BOOL firstpage_answer3_1;
@property (nonatomic, assign) BOOL firstpage_answer3_2;
@property (nonatomic, assign) BOOL firstpage_answer3_3;


@property (nonatomic,strong) NSString *firstpage_otherString1;


@property (nonatomic, assign) NSInteger secondpage_answer1;
@property (nonatomic, assign) NSInteger secondpage_answer2;
@property (nonatomic, assign) NSInteger secondpage_answer3;


@property (nonatomic, assign) NSInteger thirdpage_answer1;
@property (nonatomic, strong) NSString* thirdpage_string1;

@property (nonatomic, assign) NSInteger thirdpage_answer2;
@property (nonatomic, assign) NSInteger thirdpage_answer3;
@property (nonatomic, strong) NSString* thirdpage_string3;

@property (nonatomic, assign) NSInteger thirdpage_answer4;




@end
