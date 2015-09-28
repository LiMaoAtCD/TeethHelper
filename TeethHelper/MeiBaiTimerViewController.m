//
//  MeiBaiTimerViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/9/3.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiTimerViewController.h"
#import "Utils.h"

#import "AlienTimerView.h"
#import "ProjectCompletedQuesitonController.h"
#import "MeiBaiConfigFile.h"

#import "WechatShareViewController.h"

#import "NetworkManager.h"
#import <SVProgressHUD.h>

#import <Masonry.h>
@interface MeiBaiTimerViewController ()

@property (nonatomic, strong) AlienTimerView *alienView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalCount;


@property (strong, nonatomic) UILabel *TextLabel;

@end

@implementation MeiBaiTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];
    
    //分享
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    UIImageView *topBgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    topBgImageView.image = [UIImage imageNamed:@"btn_complete_narmal"];
    
    [self.view addSubview:topBgImageView];
    
    
    [topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    UIImageView *timerTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_clock"]];
    
    [topBgImageView addSubview:timerTag];
    
    
    
    self.TextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.TextLabel.text = @"您当前已使用仪器00:00分钟";
    self.TextLabel.textAlignment = NSTextAlignmentCenter;
    self.TextLabel.textColor = [UIColor whiteColor];
    self.TextLabel.font =[UIFont systemFontOfSize:17.0];
    
    [topBgImageView addSubview:self.TextLabel];
    
    [self.TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topBgImageView.mas_centerX);
        make.centerY.equalTo(topBgImageView.mas_centerY);
    }];
    
    [timerTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.TextLabel.mas_centerY);
        make.right.equalTo(self.TextLabel.mas_left).offset(-8);
        make.width.equalTo(@17);
        make.height.equalTo(@20);
    }];
    
    
    UIButton * completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [completeButton setTitle:@"完成今日美白程序" forState:UIControlStateNormal];
    
    [completeButton addTarget:self action:@selector(completeMeibai:) forControlEvents:UIControlEventTouchUpInside];
    [completeButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [self.view addSubview:completeButton];
    
    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@60);

    }];
    
    
    //圆形图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat CircleMargin = 70;
    self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
    if ([Utils isiPhone4]) {
        CGFloat CircleMargin = 90;
        self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
        self.alienView.timerLabel.font = [UIFont systemFontOfSize:80];
        
    }
    
    [self.view addSubview:_alienView];
    self.totalCount = _previousSeconds;
}
-(void)pop{
    
    [SVProgressHUD showWithStatus:@"正在取消当前美白计划"];
    [NetworkManager CancelMeiBaiProjectWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"status"] integerValue] == 2000) {
            [self.navigationController popViewControllerAnimated:YES];
        } else{
            
        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];

    }];
}

-(void)share:(UIButton*)button{
    WechatShareViewController *share = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self showDetailViewController:share sender:self];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"timer_view_going"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDurationsFromResignAndActive:) name:@"kNotificationForResignAndActive" object:nil];
    
}

-(void)addDurationsFromResignAndActive:(NSNotification *)notification{
    
    NSDictionary *temp = [notification object];
    NSTimeInterval duration  = [temp[@"duration"] doubleValue];
    
    self.totalCount += (NSInteger)duration;
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
  
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [self.timer invalidate];
    self.timer = nil;
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"timer_view_going"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)timerCount:(id)sender{
    self.totalCount++;
    
    int inputSeconds = (int)self.totalCount;
    int minutes = inputSeconds / 60;
    int seconds = inputSeconds  - minutes * 60;
    
    if (self.totalCount >= 99 * 60 + 59 ) {
        self.totalCount =  99 * 60 + 59;
        [self.timer invalidate];
      
        minutes = 99;
        seconds = 59;
    }

    
    NSString *theTime = [NSString stringWithFormat:@"%.2d'%.2d\"", minutes, seconds];
    
    [self.alienView animateToSeconds:self.totalCount];
    
    self.alienView.timerLabel.text = theTime;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.TextLabel.text = [NSString stringWithFormat:@"您当前已使用仪器%.2d:%.2d分钟",minutes,seconds];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)completeMeibai:(id)sender {
    
    [self.timer invalidate];
    self.timer = nil;
    
    [NetworkManager EndMeiBaiProjectWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //如果是治疗阶段,问卷调查
        
        if ([MeiBaiConfigFile getCurrentProject] != KEEP) {
            ProjectCompletedQuesitonController *questionVC = [[ProjectCompletedQuesitonController alloc] initWithNibName:@"ProjectCompletedQuesitonController" bundle:nil];
            [self.navigationController pushViewController:questionVC animated:YES];
        } else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
    
    
}


@end
