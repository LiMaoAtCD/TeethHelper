//
//  MeiBaiConfigFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    ENHANCE,
    STANDARD,
    GENTLE,
    KEEP
} MEIBAI_PROJECT;
@interface MeiBaiConfigFile : NSObject

/*
 获取当前治疗等级:
 温柔计划 3*8 -10天
 标准计划 4*8 -5天
 加强计划 7*8 - 3天
 */



+(void)setCurrentProject:(MEIBAI_PROJECT)project;
+(MEIBAI_PROJECT)getCurrentProject;


//设置每天治疗的次数
+(void)setCureTimesEachDay:(NSInteger)Times;
+(NSInteger)getCureTimesEachDay;

//设置治疗天数
+(void)setNeedCureDays:(NSInteger)days;
+(NSInteger)getNeedCureDays;

//设置治疗已完成的天数
+(void)setCompletedCureDays:(NSInteger)day;
+(NSInteger)getCompletedCureDays;

//设置保持已完成的天数
+(void)setCompletedKeepDays:(NSInteger)day;
+(NSInteger)getCompletedKeepDays;

//设置治疗进行中完成的天数
+(void)setProcessDays:(NSInteger)day;
+(NSInteger)getProcessDays;




//首次测白等级
+(void)setFirstCebaiLevel:(NSInteger)level;
+(NSInteger)firstCeBaiLevel;


@end
