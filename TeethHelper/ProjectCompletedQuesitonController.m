//
//  ProjectCompletedQuesitonController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/17.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ProjectCompletedQuesitonController.h"
#import <Masonry.h>

@interface ProjectCompletedQuesitonController ()


@property (weak, nonatomic) IBOutlet UIImageView *questionIndexImageView;

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *finishedButton;
@property (nonatomic, strong) UILabel *questionLabel;


@end

@implementation ProjectCompletedQuesitonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _questionIndexImageView.image = [UIImage imageNamed:@"MB_completed_question1"];
    
    _questionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _questionLabel.textColor = [UIColor whiteColor];
    _questionLabel.text = @"Q1:您本次美白共持续了多长时间?";
    
    [self.view addSubview:_questionLabel];
    
    [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(180);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@30);
    }];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [_nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.equalTo(@40);
    }];
    
    _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_previousButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [_previousButton setTitle:@"上一题" forState:UIControlStateNormal];
    [_previousButton addTarget:self action:@selector(previousQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_previousButton];
    
    [_previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view.mas_centerX).offset(-4);
        make.height.equalTo(@40);
    }];
    
    
    _finishedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_finishedButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [_finishedButton setTitle:@"完成" forState:UIControlStateNormal];
    [_finishedButton addTarget:self action:@selector(finishQuesiton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishedButton];
    
    
    
    [_finishedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_centerX).offset(4);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(@40);
    }];
    
    _previousButton.hidden = YES;
    _finishedButton.hidden = YES;
    
    
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

-(void)nextQuestion:(UIButton *)button{
    self.questionIndexImageView.image = [UIImage imageNamed:@"MB_completed_question2"];
    self.nextButton.hidden = YES;
    self.previousButton.hidden = NO;
    self.finishedButton.hidden = NO;
}
-(void)previousQuestion:(UIButton*)button{
    self.questionIndexImageView.image = [UIImage imageNamed:@"MB_completed_question1"];
    self.nextButton.hidden = NO;
    self.previousButton.hidden = YES;
    self.finishedButton.hidden = YES;
}

-(void)finishQuesiton:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
