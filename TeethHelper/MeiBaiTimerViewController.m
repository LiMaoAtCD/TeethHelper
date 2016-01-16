//
//  MeiBaiTimerViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/9/3.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiTimerViewController.h"
#import "Utils.h"
#import <Masonry.h>
#import "AlienTimerView.h"
#import "ProjectCompletedQuesitonController.h"
#import "MeiBaiConfigFile.h"
#import "WechatShareViewController.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>


@interface MeiBaiTimerViewController ()


@property (nonatomic, strong) UIImageView *topBgImageView; //顶部绿色视图
@property (strong, nonatomic) UILabel *TextLabel;          //顶部剩余次数文本
@property (nonatomic, copy) NSString *leftCountString;      //顶部剩余次数
@property (nonatomic, strong) AlienTimerView *alienView;    //计时视图

@property (nonatomic, strong) NSTimer *timer;               //计时器
@property (nonatomic, assign) NSInteger seconds;            //秒数
@property (nonatomic, assign) NSInteger leftCount;          //剩余美白次数
@property (nonatomic, assign) MeiBaiTimerType currentTimerType; //当前计时类型
@property (nonatomic, assign) NSInteger validSeconds;            //有效秒数，用于上传服务器


@end

@implementation MeiBaiTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];
    
    [self configureTimerData];

    [self configShareButton];
    [self configureTopBGViewAndText];
    [self configureCircleView];
    [self configureCompletionButton];
    


}
-(void)configureTimerData{
    //    self.seconds = _previousSeconds;
    self.leftCount = [MeiBaiConfigFile getCureTimesEachDay];
    //    self.leftCount = 2;
    self.currentTimerType = MeiBaiTimerTypeGoing;
    
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"timer_view_going"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDurationsFromResignAndActive:) name:@"kNotificationForResignAndActive" object:nil];
    
}

//-(void)addDurationsFromResignAndActive:(NSNotification *)notification{
//    NSDictionary *temp = [notification object];
//    NSTimeInterval duration  = [temp[@"duration"] doubleValue];
//    self.seconds += (NSInteger)duration;
//}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
  
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [self endTimer];
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"timer_view_going"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



-(void)timerCount:(id)sender{
    
    //1 检查剩余美白次数是否大于零
    if (self.leftCount > 0) {
        //计时
        self.seconds++;
        [self updateLeftTimeLabelWithCount:self.leftCount];

        if (self.currentTimerType == MeiBaiTimerTypeGoing) {
            //处于美白模式时
            self.validSeconds++;

            [self.alienView countdownToSecond:self.seconds ForMaxSecond:_currentTimerType];

            //计时结束
            if (self.seconds >= 8 * 60) {
                //重置计时
                self.seconds = 0;
                
                self.currentTimerType = MeiBaiTimerTypePause;
                //剩余次数减一
                _leftCount--;
                
                //更新剩余次数视图

                if (_leftCount == 0) {
                    //剩余次数为零是结束计时
                    [self endTimer];
                }
            }
            
        } else{
            //处于暂停模式时
            [self.alienView countdownToSecond:self.seconds ForMaxSecond:_currentTimerType];
            
            if (self.seconds >= 2 * 60) {
                self.seconds = 0;
                self.currentTimerType = MeiBaiTimerTypeGoing;
            }
        }
        
    } else {
        //没有剩余次数了，结束计时
        [self endTimer];
    }
    
}

-(void)endTimer{
    [self.timer invalidate];
    self.timer = nil;
}


static BOOL delayTime = NO;
- (void)completeMeibai:(id)sender {
    if (delayTime) {
        return;
    }
    
    delayTime = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        delayTime = NO;
    });
    
    [self endTimer];
    
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

#pragma mark - 更新剩余次数

-(void)updateLeftTimeLabelWithCount:(NSInteger)count {
    self.leftCountString = [NSString stringWithFormat:@"剩余美白次数:%ld次",count - 1];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:self.leftCountString attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:40.0]
                  range:NSMakeRange(7, 1)];
    self.TextLabel.attributedText = hogan;
}

#pragma mark - 初始化分享按钮 + 顶部的绿色背景视图 + 完成美白按钮

-(void)configShareButton{
    //分享
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)share:(UIButton*)button{
    WechatShareViewController *share = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self showDetailViewController:share sender:self];
}

-(void)configureTopBGViewAndText{
    _topBgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _topBgImageView.image = [UIImage imageNamed:@"btn_complete_narmal"];
    
    [self.view addSubview:_topBgImageView];
    
    [_topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
 


    self.TextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    self.TextLabel.textAlignment = NSTextAlignmentCenter;
    self.TextLabel.textColor = [UIColor whiteColor];

    [_topBgImageView addSubview:self.TextLabel];
    
    [self.TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topBgImageView.mas_centerX);
        make.centerY.equalTo(_topBgImageView.mas_centerY);
    }];
    [self updateLeftTimeLabelWithCount:self.leftCount];

}

-(void)configureCircleView{
    //圆形图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat CircleMargin = 70;
    self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 240, width - CircleMargin * 2, width - CircleMargin * 2)];
    if ([Utils isiPhone4]) {
        CGFloat CircleMargin = 90;
        self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
        self.alienView.timerLabel.font = [UIFont systemFontOfSize:80];
    }
    
    [self.view addSubview:_alienView];
}

-(void)configureCompletionButton{
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self endTimer];
}

@end
