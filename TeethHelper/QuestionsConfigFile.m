//
//  QuestionsConfigFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionsConfigFile.h"

@implementation QuestionsConfigFile

+(void)setCompletedInitialQuestions:(BOOL)question
{
    [[NSUserDefaults standardUserDefaults] setBool:question forKey:@"user_completed_questions"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)isCompletedInitialQuestions{
    
    BOOL iscompleted = [[NSUserDefaults standardUserDefaults] boolForKey:@"user_completed_questions"];
    return iscompleted;
}

@end
