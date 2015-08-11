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
@interface AppDelegate ()

@property (nonatomic, strong) MainTabBarController *tabarController;
@property (nonatomic, strong) LoginNavigationController *loginVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BOOL isLogin = [AccountManager isLogin];
    if (isLogin) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        _loginVC = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        
        self.window.rootViewController = _loginVC;
        [self.window makeKeyAndVisible];
        
    } else {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        _tabarController = [sb instantiateViewControllerWithIdentifier:@"MainTabBarController"];
        
        self.window.rootViewController = _tabarController;
        [self.window makeKeyAndVisible];
    }
    [self configureTabBarAppearance];
    [self configSVProgressHUD];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)configureTabBarAppearance{
    UIColor *backgroundColor = [UIColor colorWithRed:188./255 green:189./255 blue:190./255 alpha:1.0];
    [[UITabBar appearance] setBackgroundImage:[AppDelegate imageFromColor:backgroundColor forSize:CGSizeMake(320, 44) withCornerRadius:0]];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:234./255 green:13./255 blue:125./255 alpha:1.0]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

//    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:234./255 green:13./255 blue:125./255 alpha:1.0]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UITabBar appearance ] setBarTintColor:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]];
    
    
    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 4, 49) withCornerRadius:0]];
    
    
    
}
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
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

@end
