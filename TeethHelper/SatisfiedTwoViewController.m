//
//  SatisfiedTwoViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/9/17.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SatisfiedTwoViewController.h"
#import <Masonry.h>
#import "Utils.h"
#import "QuestionOneView.h"
#import "SatistiedThreeViewController.h"

@interface SatisfiedTwoViewController ()


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic,strong) NSMutableArray *oneViewArrays;
@property (nonatomic,strong) NSMutableArray *twoViewArrays;
@property (nonatomic,strong) NSMutableArray *threeViewArrays;


@end

@implementation SatisfiedTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Utils ConfigNavigationBarWithTitle:@"问卷" onViewController:self];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
    [self configRightNavigationItem];
    
    [self configMainView1];
    [self configMainView2];
    [self configMainView3];
}

-(void)configRightNavigationItem{
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    
    [popButton setBackgroundImage:[UIImage imageNamed:@"Question_naviclose_normal"] forState:UIControlStateNormal];
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
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    arrowImageView.image = [UIImage imageNamed:@"quesiton_once_arrow1"];
    [arrowView addSubview:arrowImageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(arrowView);
    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.text = @"测白部分";
    label1.font = [UIFont systemFontOfSize:14.0];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [arrowView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(arrowView.mas_centerX).multipliedBy(0.33);
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
        make.centerX.equalTo(arrowView.mas_centerX).multipliedBy(1.7);
        make.centerY.equalTo(arrowView.mas_centerY);
    }];
}

-(void)configMainView3{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.scrollView addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(@650);
    }];
    
    
    //第一题
    [self configFirstQuestionView];
    //第二题
    [self configSecondQuestionView];
//    //第三题
    [self configThirdQuestionView];
//
    [self configNextButton];
    
    
}


//第1题相关

-(void)configFirstQuestionView{
    
    UILabel * question1 = [[UILabel alloc] initWithFrame:CGRectZero];
    question1.textColor = [UIColor blackColor];
    question1.text = @"Q1:请问您对治疗管理的操作过称满意吗?";
    question1.numberOfLines = 0;
    
    [self.contentView addSubview:question1];
    
    [question1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
//        make.height.equalTo(@30);
    }];

    NSArray *labels = @[@"满意",@"比较满意",@"一般",@"不满意"];
    
    self.oneViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];
        [self.oneViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.height.equalTo(@30);
            make.top.equalTo(self.contentView).offset(40 + i * 40);
            if ([Utils isiPhone4]) {
                make.height.equalTo(@25);
                make.top.equalTo(self.contentView).offset(250 + i * 30);
            }
        }];
    }
    
    [self.oneViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == 0) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    
    self.secondpage_answer1 = 0;
    
}

-(void)selectIndex:(UITapGestureRecognizer *)tap{
    [self.oneViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == tap.view.tag) {
            [view didSelectionAtIndex:Selected];
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.secondpage_answer1 = tap.view.tag;

}

//第2题相关

-(void)configSecondQuestionView{
    
    UILabel * question2 = [[UILabel alloc] initWithFrame:CGRectZero];
    question2.textColor = [UIColor blackColor];
    question2.text = @"Q2:您对目前治疗管理内容满意吗?";
    
    [self.contentView addSubview:question2];
    
    [question2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(200);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@30);
    }];
    //
    NSArray *labels = @[@"满意",@"比较满意",@"一般",@"不满意"];
    
    self.twoViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex2:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];
        [self.twoViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.height.equalTo(@30);
            make.top.equalTo(self.contentView).offset(230 + i * 40);
            if ([Utils isiPhone4]) {
                make.height.equalTo(@25);
                make.top.equalTo(self.contentView).offset(250 + i * 30);
            }
        }];
    }
    
    [self.twoViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == 0) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.secondpage_answer2 = 0;

    
}

-(void)selectIndex2:(UITapGestureRecognizer *)tap{
    [self.twoViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == tap.view.tag) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.secondpage_answer2 = tap.view.tag;

}

//第3题相关

-(void)configThirdQuestionView{
    
    UILabel * question2 = [[UILabel alloc] initWithFrame:CGRectZero];
    question2.textColor = [UIColor blackColor];
    question2.text = @"Q3:您希望对治疗管理做进一步改进?";
    
    [self.contentView addSubview:question2];
    
    [question2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(380);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@30);
    }];
    //
    NSArray *labels = @[@"不需要",@"增加更多的管理选择",@"减少目前管理选择"];
    
    self.threeViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex3:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];
        [self.threeViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.height.equalTo(@30);
            make.top.equalTo(self.contentView).offset(410 + i * 40);
            if ([Utils isiPhone4]) {
                make.height.equalTo(@25);
                make.top.equalTo(self.contentView).offset(250 + i * 30);
            }
        }];
    }
    
    [self.threeViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == 0) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.secondpage_answer3 = 0;
    
}

-(void)selectIndex3:(UITapGestureRecognizer *)tap{
    [self.threeViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == tap.view.tag) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.secondpage_answer3 = tap.view.tag;

}



-(void)configNextButton{
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:nextButton];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(threeQuestion:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
        make.height.equalTo(@40);
        make.top.equalTo(self.contentView).offset(550);
    }];
}


-(void)threeQuestion:(id)sender{
    
    
    
    
    
    SatistiedThreeViewController *threeVC = [[SatistiedThreeViewController alloc] initWithNibName:@"SatistiedThreeViewController" bundle:nil];
    
    threeVC.firstpage_answer1 = self.firstpage_answer1;
    threeVC.firstpage_answer2 = self.firstpage_answer2;
    threeVC.firstpage_answer3_1 = self.firstpage_answer3_1;
    threeVC.firstpage_answer3_2 = self.firstpage_answer3_2;
    threeVC.firstpage_answer3_3 = self.firstpage_answer3_3;
    threeVC.firstpage_otherString1 = self.firstpage_otherString1;

    threeVC.secondpage_answer1 = self.secondpage_answer1;
    threeVC.secondpage_answer2 = self.secondpage_answer2;
    threeVC.secondpage_answer3 = self.secondpage_answer3;

    
    
    [self.navigationController pushViewController:threeVC animated:NO];

}

-(void)close:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"satisfied_quesitons"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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