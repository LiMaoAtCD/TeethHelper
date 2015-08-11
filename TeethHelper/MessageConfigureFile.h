//
//  MessageConfigureFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageConfigureFile : NSObject


+(BOOL)isOpenLocalNotification;
+(void)setOpenLocalNotification:(BOOL)open;

+(BOOL)isQuestionaireOpen;
+(void)setQuestionaireOpenLocalNotification:(BOOL)open;


@end
