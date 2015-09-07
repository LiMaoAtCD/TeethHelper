//
//  SuggestSuspendViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/31.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SuggestSuspendViewController.h"
#import "Utils.h"
#import <Masonry.h>
#import "MeiBaiConfigFile.h"

#import "NetworkManager.h"
#import <SVProgressHUD.h>

@interface SuggestSuspendViewController ()

@end

@implementation SuggestSuspendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"反馈结果" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
    
    UIView *greenBGView = [[UIView alloc] initWithFrame:CGRectZero];
    greenBGView.backgroundColor = [Utils commonColor];
    [self.view addSubview:greenBGView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label.text = @"根据您的问卷调查，我们建议您:";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0];
    
    [greenBGView addSubview:label];
    
    
    [greenBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@100);
        
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(greenBGView.mas_left).offset(20);
        make.right.equalTo(greenBGView);
        make.height.equalTo(@30);
        make.top.equalTo(greenBGView.mas_top).offset(30);
    }];
    
    //降低使用频次，调整至温柔计划
    
    UILabel *keepLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    keepLabel.text = @"暂停使用";
    keepLabel.textColor = [UIColor blackColor];
    keepLabel.font = [UIFont boldSystemFontOfSize:30.0];
    keepLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:keepLabel];
    
    [keepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY).offset(-30);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *keep2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    keep2Label.text = @"待症状消失后再尝试从温柔计划启动,如果症状持续则建议停止使用";
    keep2Label.textColor = [UIColor blackColor];
    keep2Label.font = [UIFont systemFontOfSize:15.0];
//    keep2Label.textAlignment = NSTextAlignmentCenter;
    keep2Label.numberOfLines = 2;
    [self.view addSubview:keep2Label];
    
    [keep2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(keepLabel.mas_bottom).offset(8);
        
    }];
    
    //确定
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [sure addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [sure setAttributedTitle:[[NSAttributedString alloc] initWithString:@"确 定" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    
    [sure setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:sure];
    
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.equalTo(@45);
        make.top.equalTo(keepLabel).offset(100);
        
        
    }];
    
    UIButton *goOn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [goOn addTarget:self action:@selector(goOn:) forControlEvents:UIControlEventTouchUpInside];
    [goOn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"继续当前计划" attributes:@{NSForegroundColorAttributeName:[Utils commonColor]}] forState:UIControlStateNormal];
    
    [goOn setBackgroundImage:[UIImage imageNamed:@"btn_continue_normal"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:goOn];
    
    [goOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.equalTo(@45);
        make.top.equalTo(sure.mas_bottom).offset(20);
        
        
    }];


}

-(void)sure:(id)sender{
    //调整至温柔计划,不推送
    
    [SVProgressHUD showWithStatus:@"正在调整计划"];
    
    //A标准计划B加强计划C温柔计划D自定义计划E保持计划F咨询医生PAUSE暂停
    [NetworkManager ModifyProject:@"PAUSE" WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 2000) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [MeiBaiConfigFile setCurrentProject:GENTLE_NoNotification];
            [SVProgressHUD dismiss];

        } else{
            [SVProgressHUD showErrorWithStatus:@"计划调整失败"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
        [self.navigationController popToRootViewControllerAnimated:YES];

    }];
    
    
}

-(void)goOn:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"根据您的问卷调查,我们建议您暂停使用,您确定要继续当前计划吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action =[UIAlertAction actionWithTitle:@"继续当前计划" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    UIAlertAction *back =[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:back];
    
    
    [self presentViewController:alert animated:YES completion:nil];
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
