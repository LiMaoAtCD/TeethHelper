//
//  SatisfiedOneViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/9/16.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SatisfiedOneViewController.h"
#import "Utils.h"
#import <Masonry.h>
@interface SatisfiedOneViewController ()

@end

@implementation SatisfiedOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Utils ConfigNavigationBarWithTitle:@"问卷调查" onViewController:self];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem new];
    
    [self configRightNavigationItem];
    
    [self configMainView1];
    [self configMainView2];
    [self configMainView3];


}

-(void)configRightNavigationItem{
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,20)];
    
    [popButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"X" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:24.0]}] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popButton];
}

-(void)configMainView1{
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectZero];
    grayView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:grayView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.text = @"通过问卷来了解您的使用体验";
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:12.0];
    label1.textAlignment = NSTextAlignmentCenter;
    [grayView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.text = @"我们将做进一步改进";
    label2.textColor = [UIColor blackColor];
    label2.font = [UIFont systemFontOfSize:12.0];
    label2.textAlignment = NSTextAlignmentCenter;

    [grayView addSubview:label2];
    
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.equalTo(@60);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayView.mas_top).offset(8);
        make.height.equalTo(@20);
        make.left.equalTo(grayView);
        make.right.equalTo(grayView);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(8);
        make.height.equalTo(@20);
        make.left.equalTo(grayView);
        make.right.equalTo(grayView);
    }];
}

-(void)configMainView2{
    
    UIView *arrowView = [[UIView alloc] initWithFrame:CGRectZero];
    arrowView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:arrowView];
    
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@40);
    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.text = @"测白部分";
    label1.font = [UIFont systemFontOfSize:14.0];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [arrowView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(arrowView.mas_centerX).multipliedBy(0.5);
        make.centerY.equalTo(arrowView.mas_centerY);
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.text = @"治疗管理";
    label2.textColor = [UIColor whiteColor];

    label2.font = [UIFont systemFontOfSize:14.0];
    [arrowView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(arrowView.mas_centerX).multipliedBy(1.0);
        make.centerY.equalTo(arrowView.mas_centerY);

    }];

    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    label3.text = @"社区";
    label3.font = [UIFont systemFontOfSize:14.0];
    label3.textColor = [UIColor whiteColor];

    [arrowView addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(arrowView.mas_centerX).multipliedBy(1.5);
        make.centerY.equalTo(arrowView.mas_centerY);
    }];
}

-(void)configMainView3{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 500);
    
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    
}


-(void)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
