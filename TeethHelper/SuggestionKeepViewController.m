//
//  SuggestionKeepViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/31.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SuggestionKeepViewController.h"
#import "Utils.h"
#import <Masonry.h>
@interface SuggestionKeepViewController ()

@end

@implementation SuggestionKeepViewController

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
    
    
    
    //继续目前的计划
    
    UILabel *keepLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    if (_keepProject) {
        keepLabel.text = @"继续目前的计划";
        keepLabel.textColor = [UIColor blackColor];
        keepLabel.font = [UIFont systemFontOfSize:30.0];
        keepLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:keepLabel];
        
        [keepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.centerY.equalTo(self.view.mas_centerY);
            make.height.equalTo(@50);
            
        }];

    } else {
        keepLabel.text = @"请减少每日美白次数。如果症状持续，暂停使用，待症状消失后再尝试从每日最少美白次数开始";
        keepLabel.numberOfLines = 0;
        keepLabel.textColor = [UIColor blackColor];
        keepLabel.font = [UIFont systemFontOfSize:20.0];
        keepLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:keepLabel];
        
        [keepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_leftMargin).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.centerY.equalTo(self.view.mas_centerY);
            make.height.equalTo(@100);
            
        }];
    }
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [sure addTarget:self action:@selector(clickOver:) forControlEvents:UIControlEventTouchUpInside];
    [sure setAttributedTitle:[[NSAttributedString alloc] initWithString:@"确 定" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    
    [sure setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];

    
    [self.view addSubview:sure];
    
    [sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.equalTo(@45);
        make.top.equalTo(keepLabel.mas_bottom).offset(80);


    }];
    
}

-(void)clickOver:(UIButton *)button{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
