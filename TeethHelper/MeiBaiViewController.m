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

#import "MeibaiProjectController.h"

@interface MeiBaiViewController ()

@property (nonatomic, strong) AlienView *alienView;

@end

@implementation MeiBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];

    //产品介绍
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"产品介绍" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickProductIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    //分享
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self configMainView];


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.alienView animateArcTo:0.7];


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
        self.alienView.dayLabel.font = [UIFont systemFontOfSize:80];

    }
//    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
    self.alienView.day = @"10";
    
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
    
    UILabel *currentProjectLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
//    if (![MeiBaiConfigFile getCurrentProject] || [[MeiBaiConfigFile getCurrentProject] isEqualToString:@"治疗"]) {
//        currentProjectLabel.text = @"当前计划: 治疗";
//    } else{
        currentProjectLabel.text = @"当前计划: 保持";
//    }
    currentProjectLabel.textAlignment =NSTextAlignmentCenter;
    currentProjectLabel.textColor = [Utils commonColor];
    currentProjectLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:currentProjectLabel];
    
    [currentProjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(completedLabel.mas_top);
    }];
   
    //左 - 治疗
    ALienGrayView *gray1View = [[ALienGrayView alloc] initWithDays:0 forType:@"治疗"];
    
    [self.view addSubview:gray1View];
    
    [gray1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(completedLabel.mas_centerX).offset(-4);
        make.width.equalTo(@50);
        make.top.equalTo(completedLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //左 - 保持
    ALienGrayView *gray2View = [[ALienGrayView alloc] initWithDays:0 forType:@"保持"];
    
    [self.view addSubview:gray2View];
    
    [gray2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(completedLabel.mas_centerX).offset(4);
        make.width.equalTo(@50);
        make.top.equalTo(completedLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
    
    //右 -
    ALienGrayView *gray3View = [[ALienGrayView alloc] initWithDays:0 forType:@"天"];
    
    [self.view addSubview:gray3View];
    
    [gray3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(currentProjectLabel.mas_centerX).offset(-4);
        make.width.equalTo(@50);
        make.top.equalTo(currentProjectLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];



    
    
    //保持天数
    ALienGrayView *gray4View = [[ALienGrayView alloc] initWithDays:99 forType:@"次/天"];
    
    [self.view addSubview:gray4View];
    
    [gray4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentProjectLabel.mas_centerX).offset(4);
        make.width.equalTo(@50);
        make.top.equalTo(currentProjectLabel.mas_bottom).offset(4);
        make.height.equalTo(@80);
        
    }];
}

-(void)clickProductIntroduce:(UIButton *)button {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    ProductIntroduceViewController *introduceVC =[sb instantiateViewControllerWithIdentifier:@"ProductIntroduceViewController"];
    
    introduceVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:introduceVC animated:YES];
//    [self.navigationController showViewController:introduceVC sender:self];
    
    
}

-(void)share:(UIButton*)button{
    
}

-(void)beginMeibaiProject:(id)sender{
    MeibaiProjectController * projectVC = [[MeibaiProjectController alloc] initWithNibName:@"MeibaiProjectController" bundle:nil];
    projectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:projectVC animated:YES];
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

@end
