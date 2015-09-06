//
//  MessageConfigureFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MessageConfigureFile : NSObject

// 是否开启本地美白通知
+(BOOL)isOpenLocalNotification;
+(void)setOpenLocalNotification:(BOOL)open;

//开启每月提醒（保持计划）
+(void)setMonthlyNotification;
//关闭每月提醒
+(void)cancelMonthlyNotification;

// 是否开启每月通知
//+(BOOL)isOpenMonthlyNotification;
//+(void)setOpenMonthlyNotification;

// 是否开启本地问卷通知
+(BOOL)isQuestionaireOpen;
+(void)setQuestionaireOpenLocalNotification:(BOOL)open;

// 设置本地美白通知
+(void)setMeiBaiNotificationAtHour:(NSString*)hour minute:(NSString *)minute;

//设置时间
+(void)setAlertNotificationTime:(NSString *)hour andMinute:(NSString *)minute;

+(NSString *)hourForAlertNotification;
+(NSString *)minuteForAlertNotification;


+(void)cancelAlertNotification;



+(void)setQuestionNotificationDelayMinute:(NSInteger)minute;
+(void)cancelQuestionNotification;



@end
