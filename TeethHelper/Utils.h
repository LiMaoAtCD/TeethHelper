//
//  Utils.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^alertBlock)(void);

@interface Utils : NSObject

+(void)ConfigNavigationBarWithTitle:(NSString*)title onViewController:(UIViewController *)viewController;

+(UIColor *)commonColor;

+(BOOL)isiPhone4;
+(BOOL)isValidCellphoneNumber:(NSString *)phoneNumber;
+(BOOL)isValidPassword:(NSString*)password;

+(void)showAlertMessage:(NSString*)message onViewController:(UIViewController *)viewController withCompletionHandler:(alertBlock)handler;



@end
