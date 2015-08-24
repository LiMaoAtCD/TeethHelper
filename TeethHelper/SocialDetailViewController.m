//
//  SocialDetailViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/24.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialDetailViewController.h"
#import "Utils.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>



@interface SocialDetailViewController ()

@end

@implementation SocialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Utils ConfigNavigationBarWithTitle:@"主题详情" onViewController:self];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
