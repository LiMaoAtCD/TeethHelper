//
//  MeiBaiConfigFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiConfigFile.h"

@implementation MeiBaiConfigFile


+(void)setCurrentProject:(NSString *)type{
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:@"current_project"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getCurrentProject{
    
    NSString *cur = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_project"];
    
    return cur;
}
@end
