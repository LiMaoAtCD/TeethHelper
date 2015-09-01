//
//  MeibaiProjectController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeibaiProjectController.h"
#import "Utils.h"

#import "AlienTimerView.h"
#import "ProjectCompletedQuesitonController.h"
#import "MeiBaiConfigFile.h"

#import "WechatShareViewController.h"

#import "NetworkManager.h"
#import <SVProgressHUD.h>

@interface MeibaiProjectController ()

@property (nonatomic, strong) AlienTimerView *alienView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation MeibaiProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];
    
    //分享
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //圆形图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat CircleMargin = 70;
    self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
    if ([Utils isiPhone4]) {
        CGFloat CircleMargin = 90;
        self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
        self.alienView.timerLabel.font = [UIFont systemFontOfSize:80];
        
    }
    //    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
//    self.alienView.ti = @"10";
    
    [self.view addSubview:_alienView];
    
    
    self.totalCount = 0;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}



-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)share:(UIButton*)button{
    WechatShareViewController *share = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self showDetailViewController:share sender:self];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
}

-(void)timerCount:(id)sender{
    self.totalCount++;

    int inputSeconds = (int)self.totalCount;
//    int hours =  inputSeconds / 3600;
    int minutes = inputSeconds / 60;
    int seconds = inputSeconds  - minutes * 60;
    
    NSString *theTime = [NSString stringWithFormat:@"%.2d'%.2d\"", minutes, seconds];
//    NSLog(@"time %@",theTime);
    
    [self.alienView animateToSeconds:self.totalCount];
    
    if (minutes == 99 && seconds == 59) {
        
        [self.timer invalidate];
    }
    
    self.alienView.timerLabel.text = theTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}


-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
- (IBAction)completeMeibai:(id)sender {
    
    [self.timer invalidate];
    self.timer = nil;
    
    [NetworkManager EndMeiBaiProjectWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject %@",responseObject);
        
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
