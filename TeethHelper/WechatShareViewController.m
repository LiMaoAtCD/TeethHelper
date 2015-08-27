//
//  WechatShareViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/20.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "WechatShareViewController.h"
#import <Masonry.h>

#import "AppDelegate.h"
@interface WechatShareViewController ()

@property (strong, nonatomic) UIView *bgView;

@end

@implementation WechatShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.bgView =[[UIView alloc] initWithFrame:CGRectZero];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.0;
    [self.view addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top).offset(0);

    }];
    
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:shareView];

    shareView.backgroundColor =[UIColor whiteColor];
    
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
         make.right.equalTo(self.view.mas_right).offset(0);
         make.height.equalTo(@200);
    }];
    
    UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    shareLabel.text = @"分享至";
    shareLabel.textColor = [UIColor blackColor];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    
    [shareView addSubview:shareLabel];
    
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareView.mas_top).offset(8);
        make.height.equalTo(@21);
        make.centerX.equalTo(shareView.mas_centerX);
        make.width.equalTo(shareView.mas_width);
    }];
    
    
    UIButton *friends =[UIButton buttonWithType:UIButtonTypeCustom];
    [friends setImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateNormal];
    [friends addTarget:self action:@selector(shareToFriends:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:friends];
    
    [friends mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shareView.mas_centerX).multipliedBy(0.5).offset(20);
        make.height.equalTo(@50);
        make.centerY.equalTo(shareView.mas_centerY).offset(-30);
        make.width.equalTo(@50);
    }];
    
    UILabel *friendsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    friendsLabel.text = @"微信好友";
    friendsLabel.textColor = [UIColor blackColor];
    friendsLabel.textAlignment = NSTextAlignmentCenter;
    
    [shareView addSubview:friendsLabel];
    
    [friendsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(friends.mas_bottom).offset(0);
        make.height.equalTo(@21);
        make.centerX.equalTo(friends.mas_centerX);
        make.width.equalTo(shareView.mas_width).multipliedBy(0.5);
    }];
    
    UIButton *friendsZone =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [friendsZone setImage:[UIImage imageNamed:@"share_pengyouquan"] forState:UIControlStateNormal];
    [friendsZone addTarget:self action:@selector(shareToFriendsZone:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:friendsZone];
    
    [friendsZone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shareView.mas_centerX).multipliedBy(1.5).offset(-20);
        make.height.equalTo(@50);
        make.centerY.equalTo(shareView.mas_centerY).offset(-30);
        make.width.equalTo(@50);
    }];
    UILabel *friendsZoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    friendsZoneLabel.text = @"朋友圈";
    friendsZoneLabel.textColor = [UIColor blackColor];
    friendsZoneLabel.textAlignment = NSTextAlignmentCenter;
    
    [shareView addSubview:friendsZoneLabel];
    
    [friendsZoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(friendsZone.mas_bottom).offset(0);
        make.height.equalTo(@21);
        make.centerX.equalTo(friendsZone.mas_centerX);
        make.width.equalTo(shareView.mas_width).multipliedBy(0.5);
    }];
    
    UIButton *cancel =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancel setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancel];
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shareView.mas_centerX);
        make.left.equalTo(shareView.mas_left).offset(20);
        make.right.equalTo(shareView.mas_right).offset(-20);
        make.bottom.equalTo(shareView.mas_bottom).offset(-20);
        make.height.equalTo(@40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 0.2;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)cancel{
    
    self.bgView.alpha = 0.0;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)shareToFriendsZone:(UIButton *)button{
    AppDelegate *delegate  =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate sendLinkContent:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)shareToFriends:(UIButton *)button{
    AppDelegate *delegate  =(AppDelegate*)[UIApplication sharedApplication].delegate;

    [delegate sendLinkContent:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];


}
@end
