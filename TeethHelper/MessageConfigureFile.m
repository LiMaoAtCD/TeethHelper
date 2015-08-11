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




@end
