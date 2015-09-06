//
//  MeiBaiConfigFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiConfigFile.h"
#import "MessageConfigureFile.h"
@implementation MeiBaiConfigFile


+(void)setProcessDays:(NSInteger)day{
    [[NSUserDefaults standardUserDefaults] setInteger:day forKey:@"cure_process_day"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)getProcessDays{
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"cure_process_day"];
    
    return level;
}


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

+(void)setFirstCebaiLevel:(NSInteger)level{
    [[NSUserDefaults standardUserDefaults] setInteger:level forKey:@"user_first_cebai_level"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)firstCeBaiLevel{
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"user_first_cebai_level"];
    
    return level;
}



+(void)setCurrentProject:(MEIBAI_PROJECT)project{
    
//    温柔计划 3*8 -10天
//    标准计划 4*8 -5天
//    加强计划 7*8 - 3天
    
    
    //如果不是暂停计划或者咨询医生，关闭美白推送
    [MessageConfigureFile setOpenLocalNotification:YES];

    if (project == GENTLE) {
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"cure_each_times"];
        [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"cure_days"];
    } else if (project == ENHANCE){
        [[NSUserDefaults standardUserDefaults] setInteger:7 forKey:@"cure_each_times"];
        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"cure_days"];
    } else if(project == STANDARD){
        
        [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:@"cure_each_times"];
        [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"cure_days"];
    }else if(project == GENTLE_NoNotification){
        //关闭提醒
        [MessageConfigureFile setOpenLocalNotification:NO];

        [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"cure_each_times"];
        [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"cure_days"];
    } else{
        // 自定义计划
    }

    
    [[NSUserDefaults standardUserDefaults] setInteger:project forKey:@"Current_project"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(MEIBAI_PROJECT)getCurrentProject{
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"Current_project"];
    
    return level;
    
}


@end
