//
//  AppDelegate.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginNavigationController.h"
#import "MainTabBarController.h"
#import "AccountManager.h"
#import <SVProgressHUD.h>
#import "MessageConfigureFile.h"
#import "TeethStateConfigureFile.h"
#import "MeiBaiConfigFile.h"

#import "InitialNavigationController.h"
#import "QuestionsConfigFile.h"

#import "NetworkManager.h"
#import "FirstCeBaiNavigationController.h"

#import <Appirater.h>

//#import "WXApi.h"
//<WXApiDelegate>

@interface AppDelegate ()

@property (nonatomic, strong) MainTabBarController *tabarController;
@property (nonatomic, strong) LoginNavigationController *loginVC;
@property (nonatomic, strong) InitialNavigationController *questionsVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //推送配置
    [self configNotificationSettings:application];
    //第一次启动的推送配置
    [self configFirstLaunchOptions];
    //tabbar 外观配置
    [self configureTabBarAppearance];
    //HUD外观配置
    [self configSVProgressHUD];
    //status bar 外观配置
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //初始化
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _tabarController = [sb instantiateViewControllerWithIdentifier:@"MainTabBarController"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuestionsCompleted:) name:@"QuestionsCompleted" object:nil];

    //检查是否登录
    BOOL isLogin = [AccountManager isLogin];
    if (!isLogin) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        _loginVC = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"LoginSuccess" object:nil];

        self.window.rootViewController = _loginVC;
        [self.window makeKeyAndVisible];
        
    } else {
        //登录成功了
        [self loginSuccess:nil];
        
    }
//    [WXApi registerApp:@"wxc213130fe4f9b110"];
    
    [self configRate];
    
    return YES;
}

-(void)QuestionsCompleted:(id)sender{
//    self.tabarController.selectedIndex = 1;
    self.window.rootViewController = self.tabarController;
}
-(void)loginSuccess:(id)sender{
    [AccountManager setLogin:YES];
    //登录成功,检查是否初次问卷
    if (![QuestionsConfigFile isCompletedInitialQuestions]) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Questions" bundle:nil];
        self.questionsVC  = [sb instantiateViewControllerWithIdentifier:@"InitialNavigationController"];
        self.window.rootViewController = self.questionsVC;
    } else if (![AccountManager isCompletedFirstCeBai]){
        FirstCeBaiNavigationController *first = [[FirstCeBaiNavigationController alloc] init];
        
        self.window.rootViewController  = first;
    }
    else{
        self.window.rootViewController = self.tabarController;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0] ;

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    if ([AccountManager isLogin]) {
        //获取首页数据
        [self fetchFirstPageData];
    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



-(void)configureTabBarAppearance{
    
    UIColor *backgroundColor = [UIColor colorWithRed:188./255 green:189./255 blue:190./255 alpha:1.0];
    [[UITabBar appearance] setBackgroundImage:[AppDelegate imageFromColor:backgroundColor forSize:CGSizeMake(320, 44) withCornerRadius:0]];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:234./255 green:13./255 blue:125./255 alpha:1.0]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

//    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:234./255 green:13./255 blue:125./255 alpha:1.0]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UITabBar appearance ] setBarTintColor:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]];
    
    
    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 4, 49) withCornerRadius:0]];
    
    
    
}
+(UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)configSVProgressHUD{
    [SVProgressHUD setForegroundColor:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]];
}

-(void)configFirstLaunchOptions{
    
    BOOL isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch_config"];
    if (!isFirstLaunch) {
        //初次启动,开启本地通知
//        [[UIApplication sharedApplication] cancelAllLocalNotifications] ;

        [MessageConfigureFile setOpenLocalNotification:YES];
        [MessageConfigureFile setQuestionaireOpenLocalNotification:YES];
        
        [MessageConfigureFile setAlertNotificationTime:@"20" andMinute:@"0"];
        NSString *hour = [MessageConfigureFile hourForAlertNotification];
        NSString *minute = [MessageConfigureFile minuteForAlertNotification];
        [MessageConfigureFile setNotificationAtHour:hour minute:minute];
  
       
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunch_config"];
        
        //牙齿状况初始设置
//        [TeethStateConfigureFile setSensitive:NO];
//        [TeethStateConfigureFile WillStrong:YES];
//        [TeethStateConfigureFile setTeethStateLevel:0];
        
        
        // 设置治疗/保持
        [MeiBaiConfigFile setCompletedCureDays:0];
        [MeiBaiConfigFile setCompletedKeepDays:0];
        
//        首次测白，如果未完成，需要完成
        [AccountManager setCompletedFirstCeBai:NO];
        
    } else {
        
    }
    
    
    
}

-(void)configNotificationSettings:(UIApplication *)application{
    //推送设置
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
    }
//    else // iOS 7 or earlier
//    {
//        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//        [application registerForRemoteNotificationTypes:myTypes];
//    }
}




-(void)fetchFirstPageData{
    [NetworkManager fetchFirstPageWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue] == 2000) {
            NSDictionary *dictionary = responseObject[@"data"];
            
//            evaluated 是否参与了首次问卷 bool  useless
//            tested 是否参与了首次测白 bool      useless
//            cureno 累计治疗次数 integer
            [MeiBaiConfigFile setCompletedCureDays:[dictionary[@"cureno"] integerValue]];
//            keepno 累计保持次数
            [MeiBaiConfigFile setCompletedKeepDays:[dictionary[@"keepno"] integerValue]];

//            planId 当前计划ID
//            plan 当前计划
//            plantype A标准B加强C温柔D自定义E保持
//            times 计划对应次数
//            duration 计划对应分钟 好像固定为8
//            days 计划对应天数
//            processed 已完成天数
            
//            white 未完成的测白记录，如果为空就表示没有未完成的，直接进入首页。如果不为空，判断endTime是否为空，不为空表示测白已完成，但是没有填写问卷，需跳转至问卷页面。如果endTime为空则表示测白没有结束，需根据beginTime和sysTime继续计时器页面，另外还需要处理超过3倍时间的情况，这时是默认完成，直接进入问卷页面。
//            beginTime 上一次测白开始时间
//            endTime 测白结束时间
//            sysTime 当前系统时间
            
            
            
        } else{
            
            [SVProgressHUD showErrorWithStatus:@"美白数据同步失败，请稍后再试"];

        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
}



#pragma mark - 微信登录相关

//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WXApi handleOpenURL:url delegate:self];
//}
//
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [WXApi handleOpenURL:url delegate:self];
//
//}
//
//
//-(void) onResp:(BaseResp*)resp
//{
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//        //分享
//    }
//    else if([resp isKindOfClass:[SendAuthResp class]])
//    {
//         //微信登录
////        SendAuthResp *temp = (SendAuthResp*)resp;
//        
////        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
////        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
//    }
//  
//}
//
//- (void) sendLinkContent:(BOOL)session
//{
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = @"纽米";
//    message.description = @"牙齿美白神器的辅助APP，指导和管理美白过程，并附带独一无二的有趣的测白功能";
//    [message setThumbImage:[UIImage imageNamed:@"Nummi_icon.png"]];
//    
//    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
//    
//    message.mediaObject = ext;
//    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
//    
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    
//    if (session) {
//        req.scene = WXSceneSession;
//    } else{
//        req.scene = WXSceneTimeline;
//    }
//
//    
//    [WXApi sendReq:req];
//}


#pragma mark -app 评分

-(void)configRate{
    [Appirater setDebug:NO];

    [Appirater setAppId:@"770699556"];
    [Appirater setDaysUntilPrompt:5];
    [Appirater setUsesUntilPrompt:0];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:40];
    [Appirater appLaunched:YES];
    [Appirater setCustomAlertTitle:@""];
    [Appirater setCustomAlertMessage:@"请到APP store帮我们评分吧"];
    [Appirater setCustomAlertRateButtonTitle:@"去评分"];
    [Appirater setCustomAlertCancelButtonTitle:@"不,谢谢"];
    [Appirater setCustomAlertRateLaterButtonTitle:@"稍后再去"];
}
@end
