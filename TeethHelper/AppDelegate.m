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

    //检查是否登录
    BOOL isLogin = [AccountManager isLogin];
    if (!isLogin) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        _loginVC = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"LoginSuccess" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuestionsCompleted:) name:@"QuestionsCompleted" object:nil];

        self.window.rootViewController = _loginVC;
        [self.window makeKeyAndVisible];
        
    } else {
        //登录成功了
        [self loginSuccess:nil];
    }
   
    return YES;
}

-(void)QuestionsCompleted:(id)sender{
    self.tabarController.selectedIndex = 1;
    self.window.rootViewController = self.tabarController;
}
-(void)loginSuccess:(id)sender{
    [AccountManager setLogin:YES];
    //登录成功,检查是否初次问卷
    if (![QuestionsConfigFile isCompletedInitialQuestions]) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Questions" bundle:nil];
        self.questionsVC  = [sb instantiateViewControllerWithIdentifier:@"InitialNavigationController"];
        self.window.rootViewController = self.questionsVC;
    } else{
        self.window.rootViewController = self.tabarController;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0] ;

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
    
    BOOL isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch"];
    if (!isFirstLaunch) {
        //初次启动,开启本地通知
//        [[UIApplication sharedApplication] cancelAllLocalNotifications] ;

        [MessageConfigureFile setOpenLocalNotification:YES];
        [MessageConfigureFile setQuestionaireOpenLocalNotification:YES];
        
        [MessageConfigureFile setAlertNotificationTime:@"20" andMinute:@"0"];
        NSString *hour = [MessageConfigureFile hourForAlertNotification];
        NSString *minute = [MessageConfigureFile minuteForAlertNotification];
        [MessageConfigureFile setNotificationAtHour:hour minute:minute];
  
       
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunch"];
        
        //牙齿状况初始设置
//        [TeethStateConfigureFile setSensitive:NO];
//        [TeethStateConfigureFile WillStrong:YES];
//        [TeethStateConfigureFile setTeethStateLevel:0];
        
        
        // 设置治疗/保持
        [MeiBaiConfigFile setCureStage:YES];
        [MeiBaiConfigFile setCompletedCureDays:0];
        [MeiBaiConfigFile setCompletedKeepDays:0];
        
        
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
@end
