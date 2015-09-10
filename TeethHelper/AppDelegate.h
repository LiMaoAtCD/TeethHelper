//
//  AppDelegate.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)sendLinkContent:(BOOL)session;


/**
 *  首页点击分享
 *
 *  @param session 是否是会话
 *  @param days    processedDay
 */
-(void)sendLinkContent1:(BOOL)session withProcessedDays:(NSInteger)days;




-(void)sendLinkContent2:(BOOL)session withWhiteDU:(NSString *)du beatRate:(NSString*)rate;



/**
 *  其他分享
 *
 *  @param session 是否为回话
 */
-(void)sendLinkContent:(BOOL)session;

@end

