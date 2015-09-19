//
//  MeiBaiViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiViewController.h"
#import "Utils.h"
#import "ProductIntroduceViewController.h"
#import "AlienView.h"
#import "ALienGrayView.h"
#import <Masonry.h>
#import "MeiBaiConfigFile.h"
#import "MessageConfigureFile.h"
#import "MeiBaiTimerViewController.h"
#import "WechatShareViewController.h"
#import "ProjectCompletedQuesitonController.h"

#import <Appirater.h>

#import "NetworkManager.h"
#import <SVProgressHUD.h>
#import "AccountManager.h"


#import "SatisfiedNavigationController.h"


@interface MeiBaiViewController ()

@property (nonatomic, strong) AlienView *alienView;
@property (nonatomic, strong) ALienGrayView *gray1View;
@property (nonatomic, strong) ALienGrayView *gray2View;
@property (nonatomic, strong) ALienGrayView *gray3View;
@property (nonatomic, strong) ALienGrayView *gray4View;

@property (nonatomic, strong) UILabel *currentProjectLabel;


@end

@implementation MeiBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];

    //产品介绍按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"产品介绍" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickProductIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    //分享按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //主视图
    [self configMainView];
}
-(void)configMainView{
    
    //计划进程
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.text = @"当前计划进程";
    label.textColor = [Utils commonColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(68);
        make.height.equalTo(@50);
    }];
    
    //圆形图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat CircleMargin = 70;
    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
    if ([Utils isiPhone4]) {
        CGFloat CircleMargin = 90;
        self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 110, width - CircleMargin * 2, width - CircleMargin * 2)];
//        self.alienView.dayLabel.font = [UIFont systemFontOfSize:80];
        
    }
    //    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
//    self.alienView.day = @"10";
    
    self.alienView.day = @"0";
    [self.view addSubview:_alienView];
    
    
    //
    UIButton *beginProjectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [beginProjectButton setBackgroundImage:[UIImage imageNamed:@"btn_start_normal"] forState:UIControlStateNormal];
    [beginProjectButton setBackgroundImage:[UIImage imageNamed:@"btn_start_normal"] forState:UIControlStateHighlighted];
    [beginProjectButton setTitle:@"开始美白程序" forState:UIControlStateNormal];
    [beginProjectButton addTarget:self action:@selector(beginMeibaiProject:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:beginProjectButton];
    
    [beginProjectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alienView.mas_bottom).offset(15);
        make.width.equalTo(@150);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@35);
    }];
    
    UILabel *completedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    completedLabel.text = @"已完成计划";
    completedLabel.textAlignment =NSTextAlignmentCenter;
    completedLabel.textColor = [Utils commonColor];
    completedLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:completedLabel];
    
    [completedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beginProjectButton.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_centerX).offset(0);
    }];
    
    _currentProjectLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    //    if (![MeiBaiConfigFile getCurrentProject] || [[MeiBaiConfigFile getCurrentProject] isEqualToString:@"治疗"]) {
    //        currentProjectLabel.text = @"当前计划: 治疗";
    //    } else{
    _currentProjectLabel.text = @"当前计划: 保持";
    //    }
    _currentProjectLabel.textAlignment =NSTextAlignmentCenter;
    _currentProjectLabel.textColor = [Utils commonColor];
    _currentProjectLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_currentProjectLabel];
    
    [_currentProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(completedLabel.mas_top);
    }];
    
    //左 - 治疗
    _gray1View = [[ALienGrayView alloc] initWithDays:0 forType:@"治疗"];
    
    [self.view addSubview:_gray1View];
    
    [_gray1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(completedLabel.mas_centerX).offset(-4);
        make.width.equalTo(@50);
        make.top.equalTo(completedLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //左 - 保持
    _gray2View = [[ALienGrayView alloc] initWithDays:0 forType:@"保持"];
    
    [self.view addSubview:_gray2View];
    
    [_gray2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(completedLabel.mas_centerX).offset(4);
        make.width.equalTo(@50);
        make.top.equalTo(completedLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //右 -
    _gray3View = [[ALienGrayView alloc] initWithDays:0 forType:@"天"];
    
    [self.view addSubview:_gray3View];
    
    [_gray3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_currentProjectLabel.mas_centerX).offset(-4);
        make.width.equalTo(@50);
        make.top.equalTo(_currentProjectLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //保持天数
    _gray4View = [[ALienGrayView alloc] initWithDays:0 forType:@"次/天"];
    
    [self.view addSubview:_gray4View];
    
    [_gray4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_currentProjectLabel.mas_centerX).offset(4);
        make.width.equalTo(@50);
        make.top.equalTo(_currentProjectLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
    if (![AccountManager isLogin]) {
        return;
    }
    
    [NetworkManager fetchFirstPageWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 2000) {
            NSDictionary *data = responseObject[@"data"];
            
            //保持天数
            NSInteger keepNo = [data[@"keepno"] integerValue];
            
            [MeiBaiConfigFile setCompletedKeepDays:keepNo];
            //治疗天数
            NSInteger cureNo = [data[@"cureno"] integerValue];
            [MeiBaiConfigFile setCompletedCureDays:cureNo];
            
            NSDictionary *plan  = data[@"plan"];
            
            //治疗进行的天数
            NSInteger processedDays = [plan[@"processed"] integerValue];
            [MeiBaiConfigFile setProcessDays:processedDays];
            
            NSInteger days = [plan[@"days"] integerValue];
            
            [MeiBaiConfigFile setNeedCureDays:days];
            NSInteger times = [plan[@"times"] integerValue];
            [MeiBaiConfigFile setCureTimesEachDay:times];
            
//A标准计划B加强计划C温柔计划D自定义计划E保持计划F咨询医生PAUSE暂停
            NSString *planType = plan[@"plantype"];
            
            if ([planType isEqualToString:@"E"]) {
                [MeiBaiConfigFile setCurrentProject:KEEP];
            } else if ([planType isEqualToString:@"A"]){
                [MeiBaiConfigFile setCurrentProject:STANDARD];
            }else if ([planType isEqualToString:@"B"]){
                [MeiBaiConfigFile setCurrentProject:ENHANCE];
            }else if ([planType isEqualToString:@"C"]){
                [MeiBaiConfigFile setCurrentProject:GENTLE];
            }else if ([planType isEqualToString:@"F"] || [planType isEqualToString:@"PAUSE"]){
                [MeiBaiConfigFile setCurrentProject:GENTLE_NoNotification];
            }else{
                //自定义计划
                [MeiBaiConfigFile setCurrentProject:USER_DEFINED];
                
            }
            
            if ([MeiBaiConfigFile getCurrentProject] != KEEP) {
                //如果是治疗阶段
                NSInteger needday = [MeiBaiConfigFile getNeedCureDays];
                NSInteger times = [MeiBaiConfigFile getCureTimesEachDay];
                self.gray3View.hidden = NO;
                
                self.gray3View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)needday];
                self.gray4View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)times];
                
                NSInteger processDays = [MeiBaiConfigFile getProcessDays];
                //        NSInteger processDays = 2;
                
                self.alienView.day = [NSString stringWithFormat:@"%ld",(long)processDays];
                
                [self.alienView animateArcTo:processDays * 1.0 / needday];
                _currentProjectLabel.text = @"当前计划: 治疗";
                
            } else{
                //保持阶段
                [self.alienView animateArcTo:1.0];
                self.alienView.day = @"1";
                
                self.gray3View.hidden = YES;
                self.gray4View.daysLabel.text = @"4";
                _currentProjectLabel.text = @"当前计划: 保持";
                
            }
            
            NSInteger completedCuredays = [MeiBaiConfigFile getCompletedCureDays];
            NSInteger completedkeepdays = [MeiBaiConfigFile getCompletedKeepDays];
            
            if (completedCuredays >= 100) {
                completedCuredays = 99;
            }
            if (completedkeepdays >= 100) {
                completedkeepdays = 99;
            }
            
            self.gray1View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)completedCuredays];
            self.gray2View.daysLabel.text = [NSString stringWithFormat:@"%ld",(long)completedkeepdays];
            
            
            if ([[data allKeys] containsObject:@"white"]) {
                //有未完成的计划
                NSDictionary *temp = data[@"white"];
                
                if ([[temp allKeys] containsObject:@"endTime"]) {
                    //测白已完成，没有做问卷
                    
                    ProjectCompletedQuesitonController *questionVC = [[ProjectCompletedQuesitonController alloc] initWithNibName:@"ProjectCompletedQuesitonController" bundle:nil];
                    questionVC.hidesBottomBarWhenPushed = YES;

                    [self.navigationController pushViewController:questionVC animated:YES];
                    
                } else{
                    //判断systime 跟begintime 是否超过3倍计划时间
                    NSString *systime = temp[@"sysTime"];
                    NSString *beginTime = temp[@"beginTime"];
                    
                    
                    //获取当前时间差
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    
                    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    
                    NSDate* sysDate = [formatter dateFromString:systime];
                    NSDate* beginDate = [formatter dateFromString:beginTime];
                    
                    NSTimeInterval distanceBetweenDates = [sysDate timeIntervalSinceDate:beginDate];
                    
                    double secondsInAnHour = 60;
                    NSInteger minutesBetweenDates = distanceBetweenDates / secondsInAnHour;
                    
                    
                    //获取计划时间
                    
                    NSInteger times = [MeiBaiConfigFile getCureTimesEachDay];
                    
                    NSInteger ProjectTime = times * 24;
                    
                    if (minutesBetweenDates > ProjectTime) {
                        //超过三倍计划时间了
                        
                        //并且不是保持计划
                        if ([MeiBaiConfigFile getCurrentProject] != KEEP) {
                            //问卷
                            
                            ProjectCompletedQuesitonController *questionVC = [[ProjectCompletedQuesitonController alloc] initWithNibName:@"ProjectCompletedQuesitonController" bundle:nil];
                            questionVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:questionVC animated:YES];
                        } else {
                            //不做任何东西，理论上不应该出现这个情况，因为超过三倍时间直接记录完成了，没有white
                        }
                        
                    } else{
                        //没有超过三倍时间，计时器继续计时
                        
                        MeiBaiTimerViewController * projectVC = [[MeiBaiTimerViewController alloc] init];
                        projectVC.hidesBottomBarWhenPushed = YES;
                        projectVC.previousSeconds = distanceBetweenDates;
                        [self.navigationController pushViewController:projectVC animated:YES];
                        
                        
                        //如果是治疗计划，判断问卷提醒是否开启了，如果开启了，计时3倍美白时间
                        if ([MeiBaiConfigFile getCurrentProject] != KEEP) {
                            if ([MessageConfigureFile isQuestionaireOpen]) {
                                
                                NSInteger timesADay =  [MeiBaiConfigFile getCureTimesEachDay];
                                //需要延迟3倍
                                NSInteger delayTime = timesADay * 24;
                                
                                [MessageConfigureFile setQuestionNotificationDelayMinute:delayTime];
                            }
                        }
                    }
                }
            } else{
                //没有未完成的计划
            }
        } else{
            
            
        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    NSDate *lastDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"satisfied_question_date"];
    NSDate *nowDate = [NSDate date];
    
    if (lastDate == nil) {
        NSInteger days = [[NSUserDefaults standardUserDefaults] integerForKey:@"satisfied_quesitons_count"];
        
        days++;
        [[NSUserDefaults standardUserDefaults] setInteger:days forKey:@"satisfied_quesitons_count"];
        [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"satisfied_question_date"];
    }else{
        double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
        if (
            (int)(([nowDate timeIntervalSince1970] + timezoneFix)/(24*3600)) -
            (int)(([lastDate timeIntervalSince1970] + timezoneFix)/(24*3600))
            != 0)
        {
            NSInteger days = [[NSUserDefaults standardUserDefaults] integerForKey:@"satisfied_quesitons_count"];
            
            days++;
            [[NSUserDefaults standardUserDefaults] setInteger:days forKey:@"satisfied_quesitons_count"];
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"satisfied_question_date"];
            
            if (days == 6) {
                
                if (![[NSUserDefaults standardUserDefaults] boolForKey:@"satisfied_quesitons"]) {
                    SatisfiedNavigationController *satisfiedVC = [[SatisfiedNavigationController alloc] init];
                    
                    [self presentViewController:satisfiedVC animated:YES completion:nil];
                    
                }
            }
            
        }

    }
    


//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"satisfied_quesitons"] && 5 == 5) {
//        SatisfiedNavigationController *satisfiedVC = [[SatisfiedNavigationController alloc] init];
//        
//        [self presentViewController:satisfiedVC animated:YES completion:nil];
//
//    }
    
    
}


-(void)clickProductIntroduce:(UIButton *)button {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    ProductIntroduceViewController *introduceVC =[sb instantiateViewControllerWithIdentifier:@"ProductIntroduceViewController"];
    
    introduceVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:introduceVC animated:YES];
    
    
}

-(void)share:(UIButton*)button{
    WechatShareViewController *wechatShare = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    
    wechatShare.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    wechatShare.isMainShare = YES;
    wechatShare.days = [MeiBaiConfigFile getProcessDays];
    [self showDetailViewController:wechatShare sender:self];
}

-(void)beginMeibaiProject:(id)sender{
    
    //记录美白次数
    [Appirater userDidSignificantEvent:YES];
    
    //上传服务器，开始计时
    [SVProgressHUD showWithStatus:@"正在启动美白计划"];
    [NetworkManager BeginMeiBaiProjectWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            
            [SVProgressHUD dismiss];
            
            MeiBaiTimerViewController * projectVC = [[MeiBaiTimerViewController alloc] initWithNibName:@"MeiBaiTimerViewController" bundle:nil];
            projectVC.hidesBottomBarWhenPushed = YES;
            projectVC.previousSeconds = 0;

            [self.navigationController pushViewController:projectVC animated:YES];
            
            
            //如果是治疗计划，判断问卷提醒是否开启了，如果开启了，计时3倍美白时间
            if ([MeiBaiConfigFile getCurrentProject] != KEEP) {
                if ([MessageConfigureFile isQuestionaireOpen]) {
                    
                    
                   NSInteger timesADay =  [MeiBaiConfigFile getCureTimesEachDay];
                    //需要延迟3倍,加3分钟为了防止本地时间比服务器时间早了，没有弹出问卷，弹出计时器了
                    NSInteger delayTime = timesADay * 24 + 3;

                    [MessageConfigureFile setQuestionNotificationDelayMinute:delayTime];
                }
            }
        } else{
            [SVProgressHUD showErrorWithStatus:@"美白计划启动失败"];
        }
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
