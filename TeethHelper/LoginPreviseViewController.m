//
//  LoginPreviseViewController.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/6.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "LoginPreviseViewController.h"
#import "SplashViewController.h"
@interface LoginPreviseViewController ()

@end

@implementation LoginPreviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"_first_launch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"_first_launch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [self addSplashView];
    }
    
    

}

-(void)addSplashView{
    
    SplashViewController *splashVC = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    
    [self presentViewController:splashVC animated:NO completion:^{
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
