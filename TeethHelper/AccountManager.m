//
//  AccountManager.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

+(BOOL)isLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
   BOOL islogin = [defaults boolForKey:@"Account_login"];
    return islogin;
}
+(void)setLogin:(BOOL)login{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:login forKey:@"Account_login"];
    [defaults synchronize];
}

@end
