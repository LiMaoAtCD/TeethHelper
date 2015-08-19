//
//  MeiBaiConfigFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiConfigFile.h"

@implementation MeiBaiConfigFile


//区分是否在治疗阶段
+(BOOL)isCureStage{
    BOOL iscure = [[NSUserDefaults standardUserDefaults] boolForKey:@"cure_stage"];
    return iscure;
}
+(void)setCureStage:(BOOL)cure{
    [[NSUserDefaults standardUserDefaults] setBool:cure forKey:@"cure_stage"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [self setBeginKeepProject:!cure];
    
}

//+(void)setBeginKeepProject:(BOOL)keep{
//    [[NSUserDefaults standardUserDefaults] setBool:keep forKey:@"cure_keep_project"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//+(BOOL)isKeepProject{
//    BOOL iscure = [[NSUserDefaults standardUserDefaults] boolForKey:@"cure_keep_project"];
//    return iscure;
//}



//设置每天治疗的次数
+(void)setCureTimesEachDay:(NSInteger)Times{
    [[NSUserDefaults standardUserDefaults] setInteger:Times forKey:@"cure_each_times"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSInteger)getCureTimesEachDay{
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"cure_each_times"];
    
    return level;
}

//设置治疗天数
+(void)setNeedCureDays:(NSInteger)days{
    
    [[NSUserDefaults standardUserDefaults] setInteger:days forKey:@"cure_days"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSInteger)getNeedCureDays{
    
    NSInteger day = [[NSUserDefaults standardUserDefaults] integerForKey:@"cure_days"];
    return day;
}

//设置治疗已完成的天数
+(void)setCompletedCureDays:(NSInteger)day{
    [[NSUserDefaults standardUserDefaults] setInteger:day forKey:@"cure_completed_days"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)getCompletedCureDays{
    NSInteger day = [[NSUserDefaults standardUserDefaults] integerForKey:@"cure_completed_days"];
    
    return day;
}

//设置保持已完成的天数
+(void)setCompletedKeepDays:(NSInteger)day{
    [[NSUserDefaults standardUserDefaults] setInteger:day forKey:@"cure_keeping_days"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)getCompletedKeepDays{
    NSInteger day = [[NSUserDefaults standardUserDefaults] integerForKey:@"cure_keeping_days"];
    
    return day;
}


@end
