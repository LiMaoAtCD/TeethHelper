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

@end
