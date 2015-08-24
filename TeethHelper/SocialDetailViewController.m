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
#import "WechatShareViewController.h"


@interface SocialDetailViewController ()

@end

@implementation SocialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Utils ConfigNavigationBarWithTitle:@"主题详情" onViewController:self];
    UIImage *image = [UIImage imageNamed:@"social_share_pressed"];
    UIButton *publish = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
    [publish setImage:image forState:UIControlStateNormal];
    [publish setImage:[UIImage imageNamed:@"social_share_normal"] forState:UIControlStateHighlighted];
    
    [publish addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publish];

    
    
}








-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)share:(UIButton *)button{
    WechatShareViewController *wechat = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    wechat.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:wechat animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
