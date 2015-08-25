//
//  SocialCommentViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/25.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialCommentViewController.h"
#import <Masonry.h>
@interface SocialCommentViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic , strong) UIView *commentView;

@property (nonatomic , strong) UITextView *textView;


@end


@implementation SocialCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor =[UIColor clearColor];
    
    self.bgView = [[UIView alloc] initWithFrame:self.view.frame];
    
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.0;
    
    [self.view addSubview:self.bgView];
    
    
    self.commentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.commentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:self.commentView];

    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text =@"回复";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font =[UIFont systemFontOfSize:18.0];
    [self.commentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.centerX.equalTo(self.commentView.mas_centerX);
        make.height.equalTo(@30);
        make.top.equalTo(self.commentView.mas_top).offset(8);
    }];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancel setImage:[UIImage imageNamed:@"btn_close_pressed"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelComment:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentView addSubview:cancel];
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentView.mas_left).offset(8);
        make.top.equalTo(self.commentView.mas_top).offset(8);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAttributedTitle:[[NSAttributedString alloc] initWithString:@"提交" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]}] forState:UIControlStateNormal];
    [send setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentView addSubview:send];
    
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentView.mas_right).offset(-8);
        make.top.equalTo(self.commentView.mas_top).offset(8);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
    self.textView.delegate = self;
    
    [self.commentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentView).offset(8);
        make.right.equalTo(self.commentView).offset(-8);
        make.top.equalTo(label.mas_bottom).offset(8);
        make.bottom.equalTo(self.commentView).offset(-8);

    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 0.2;

    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelComment:(id)sender{
    
}

-(void)sendComment:(id)sender{

}

@end
