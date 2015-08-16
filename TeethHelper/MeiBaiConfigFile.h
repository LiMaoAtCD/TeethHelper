//
//  MeiBaiConfigFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeiBaiConfigFile : NSObject

/*
 获取当前治疗等级:
 温柔计划 3*8 -10天
 标准计划 4*8 -5天
 加强计划 7*8 - 3天
 */


//区分是否在治疗阶段
+(BOOL)isCureStage;
+(void)setCureStage:(BOOL)cure;


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



//是否保持美白计划
+(void)setBeginKeepProject:(BOOL)keep;
+(BOOL)isKeepProject;

@end
