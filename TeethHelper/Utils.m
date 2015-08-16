//
//  Utils.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "Utils.h"
#import "UIColor+HexRGB.h"
@implementation Utils

+(void)ConfigNavigationBarWithTitle:(NSString*)title onViewController:(UIViewController *)viewController{
    
    viewController.title = title;
    [viewController.navigationController.navigationBar setBarTintColor:[UIColor colorWithHex:@"f8f8f8" alpha:1.0]];
    
    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImage *image = [UIImage imageNamed:@"back_normal"];
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
    
    [popButton setImage:image forState:UIControlStateNormal];
    [popButton addTarget:viewController action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popButton];
    

}

+(UIColor *)commonColor{
    return [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
}

+(BOOL)isiPhone4{
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    if (height < 500.0) {
        return YES;
    } else{
        return NO;
    }
}

+(BOOL)isValidCellphoneNumber:(NSString *)phoneNumber{
    if ([phoneNumber length] == 0) {
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|17[678]|(18[0-9]|14[57]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    return isMatch;
}
//#pragma 正则匹配用户密码6-16位数字或字母组合
+(BOOL)isValidPassword:(NSString*)password{
    NSString *pattern = @"^[\\da-zA-Z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}
@end
