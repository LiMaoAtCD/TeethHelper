//
//  MessageConfigureFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MessageConfigureFile.h"

@implementation MessageConfigureFile

+(BOOL)isOpenLocalNotification{
    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"Local_Notification"];
    return isOpen;
}
+(void)setOpenLocalNotification:(BOOL)open{
    [[NSUserDefaults standardUserDefaults] setBool:open forKey:@"Local_Notification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)isQuestionaireOpen{
    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"Local_question_Notification"];
    return isOpen;
}
+(void)setQuestionaireOpenLocalNotification:(BOOL)open{
    [[NSUserDefaults standardUserDefaults] setBool:open forKey:@"Local_question_Notification"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(void)setNotificationAtHour:(NSString*)hour minute:(NSString *)minute{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *now = [NSDate date];
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSCalendarUnitYear |       NSCalendarUnitMonth |  NSCalendarUnitDay )
                                                   fromDate:now];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay: [dateComponents day]];
    [components setMonth: [dateComponents month]];
    [components setYear: [dateComponents year]];
    
    [components setHour: [hour integerValue]];
    [components setMinute: [minute integerValue]];
    [components setSecond: 0];
    
    [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
    NSDate *dateToFire = [calendar dateFromComponents:components];
    
    UILocalNotification *alarm = [[UILocalNotification alloc] init];
    if (alarm) {
        alarm.fireDate = dateToFire;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = kCFCalendarUnitDay;
        alarm.alertBody = @"美白时间到了,开始美白计划吧";
        alarm.alertAction = @"开始美白吧";
        alarm.soundName = UILocalNotificationDefaultSoundName;
        alarm.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:alarm];
}

+(void)cancelAlertNotification{
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in notificationArray){
        if ([notification.alertBody isEqualToString:@"美白时间到了,开始美白计划吧"]) {
            // delete this notification
            [[UIApplication sharedApplication] cancelLocalNotification:notification] ;
        }
    }
}


+(void)setQuestionOpenLocalNotification{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *now = [NSDate date];
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSCalendarUnitYear |       NSCalendarUnitMonth |  NSCalendarUnitDay )
                                                   fromDate:now];
    NSDateComponents *timeComponents = [calendar components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
                                                   fromDate:now];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay: [dateComponents day]];
    [components setMonth: [dateComponents month]];
    [components setYear: [dateComponents year]];
    
    [components setHour: [timeComponents hour]];
    [components setMinute: [timeComponents minute] + 10];
    [components setSecond: [timeComponents second]];
    
    [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
    NSDate *dateToFire = [calendar dateFromComponents:components];
    
    UILocalNotification *alarm = [[UILocalNotification alloc] init];
    if (alarm) {
        alarm.fireDate = dateToFire;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = kCFCalendarUnitDay;
        alarm.alertBody = @"开启问卷调查";
        alarm.alertAction = @"";
        alarm.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] +1;
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:alarm];

}
+(void)cancelQuestionNotification{
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in notificationArray){
        if ([notification.alertBody isEqualToString:@"开启问卷调查"]) {
            // delete this notification
            [[UIApplication sharedApplication] cancelLocalNotification:notification] ;
        }
    }
}

+(void)setAlertNotificationTime:(NSString *)hour andMinute:(NSString *)minute{
    
    [[NSUserDefaults standardUserDefaults] setObject:hour forKey:@"local_notification_hour"];
    [[NSUserDefaults standardUserDefaults] setObject:minute forKey:@"local_notification_minute"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)hourForAlertNotification{
    
    NSString *hour = [[NSUserDefaults standardUserDefaults] objectForKey:@"local_notification_hour"];
    return hour;
    
}
+(NSString *)minuteForAlertNotification{
    
    NSString *minute = [[NSUserDefaults standardUserDefaults] objectForKey:@"local_notification_minute"];
    return minute;
}








@end
