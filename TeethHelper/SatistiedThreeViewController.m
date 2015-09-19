//
//  SatistiedThreeViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/9/17.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SatistiedThreeViewController.h"
#import <Masonry.h>
#import "Utils.h"
#import "QuestionOneView.h"
#import "SatistiedThreeViewController.h"

#import "NetworkManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SatistiedThreeViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic,strong) NSMutableArray *oneViewArrays;
@property (nonatomic,strong) NSMutableArray *twoViewArrays;
@property (nonatomic,strong) NSMutableArray *threeViewArrays;
@property (nonatomic,strong) NSMutableArray *fourthViewArrays;

@property (nonatomic,strong) UITextView *textView1;
@property (nonatomic,strong) UITextView *textView2;




@end

@implementation SatistiedThreeViewController

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
    arrowImageView.image = [UIImage imageNamed:@"quesiton_once_arrow2"];
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
        make.height.equalTo(@930);
    }];
    
    
//    //第一题
    [self configFirstQuestionView];
//    //第二题
    [self configSecondQuestionView];
//    //    //第三题
    [self configThirdQuestionView];
//    //
    [self configFourthQuestionView];
    
    [self configFinishedButton];
}


//第1题相关

-(void)configFirstQuestionView{
    
    UILabel * question1 = [[UILabel alloc] initWithFrame:CGRectZero];
    question1.textColor = [UIColor blackColor];
    question1.text = @"Q1:您希望还应该增加什么内容?";
    question1.numberOfLines = 0 ;
    
    
    [self.contentView addSubview:question1];
    
    [question1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
//        make.height.equalTo(@30);
    }];
    //
    NSArray *labels = @[@"更多的美白信息",@"网上商城(能够直接购买美白产品)",@"网上商城(能够直接购买其他保健产品)",@"其他(请注明)"];
    
    self.oneViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
        view.rangeLabel.font = [UIFont systemFontOfSize:14.0];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];
        [self.oneViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@260);
            make.right.equalTo(self.contentView.mas_right);
            
            make.left.equalTo(self.contentView.mas_left).offset(20);
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
    self.thirdpage_answer1 = 0;
    
    self.textView1 = [[UITextView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.textView1];
    
    [self.textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(200);
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.equalTo(@60);
    }];
    self.textView1.layer.borderWidth = 1.0;
    self.textView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView1.keyboardType =  UIKeyboardAppearanceDefault;
    self.textView1.returnKeyType = UIReturnKeyDone;
    self.textView1.delegate = self;

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    if (textView == self.textView1) {
        self.thirdpage_string1 = textView.text;
    } else{
        self.thirdpage_string3 = textView.text;
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.thirdpage_answer1 == 3 && textView == self.textView1) {
        return YES;
    } else if(self.thirdpage_answer3 == 2 && textView == self.textView2){
        return YES;
    }else{
        return NO;
    }
}



//第2题相关

-(void)configSecondQuestionView{
    
    UILabel * question2 = [[UILabel alloc] initWithFrame:CGRectZero];
    question2.textColor = [UIColor blackColor];
    question2.text = @"Q2:您希望通过APP看到相关牙齿保健信息吗?";
    question2.numberOfLines = 0;
    [self.contentView addSubview:question2];
    
    [question2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(270);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    //
    NSArray *labels = @[@"希望",@"不希望",@"无所谓"];
    
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
            make.top.equalTo(self.contentView).offset(310 + i * 40);
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
    self.thirdpage_answer2 = 0;
    
}

//第三题
-(void)configThirdQuestionView{
    UILabel * question3 = [[UILabel alloc] initWithFrame:CGRectZero];
    question3.textColor = [UIColor blackColor];
    question3.numberOfLines = 0;
    question3.text = @"Q3:您希望通过APP还可以解决哪些牙齿问题?";
    
    [self.contentView addSubview:question3];
    
    [question3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(420);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    //
    NSArray *labels = @[@"简化操作过程",@"提高准确度",@"其他(请注明)"];
    
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
            make.top.equalTo(self.contentView).offset(460 + i * 40);
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
    self.thirdpage_answer3 = 0;

    
    
    self.textView2 = [[UITextView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.textView2];
    
    [self.textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(590);
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.width.equalTo(@200);
        make.height.equalTo(@60);
    }];
    self.textView2.layer.borderWidth = 1.0;
    self.textView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView2.keyboardType=  UIKeyboardAppearanceDefault;
    self.textView2.returnKeyType = UIReturnKeyDone;
    self.textView2.delegate = self;
    
}

//第4题相关

-(void)configFourthQuestionView{
    
    UILabel * question2 = [[UILabel alloc] initWithFrame:CGRectZero];
    question2.textColor = [UIColor blackColor];
    question2.text = @"Q4:您希望通过网上平台可以找到牙科诊所及牙医进行诊治吗?";
    question2.numberOfLines = 0;
    [self.contentView addSubview:question2];
    
    [question2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(660);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    //
    NSArray *labels = @[@"非常需要",@"一般",@"不太需要"];
    
    self.fourthViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex4:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];
        [self.fourthViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.height.equalTo(@30);
            make.top.equalTo(self.contentView).offset(700 + i * 40);
            if ([Utils isiPhone4]) {
                make.height.equalTo(@25);
                make.top.equalTo(self.contentView).offset(250 + i * 30);
            }
        }];
    }
    
    [self.fourthViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == 0) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.thirdpage_answer4 = 0;

    
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
    
    self.thirdpage_answer1 = tap.view.tag;
    
    if (tap.view.tag != 3) {
        self.thirdpage_string1 = nil;
        self.textView1.text = nil;
        [self.textView1 resignFirstResponder];
        
    } else{
        
    }
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
    self.thirdpage_answer2 = tap.view.tag;

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
    self.thirdpage_answer3 = tap.view.tag;
    
    if (tap.view.tag != 2) {
        self.thirdpage_string3 = nil;
        self.textView2.text = nil;
        [self.textView2 resignFirstResponder];

    } else{
        
    }

}

-(void)selectIndex4:(UITapGestureRecognizer *)tap{
    [self.fourthViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == tap.view.tag) {
            [view didSelectionAtIndex:Selected];
            
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    self.thirdpage_answer4 = tap.view.tag;

}


-(void)configFinishedButton{
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:nextButton];
    [nextButton setTitle:@"完成问卷" forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(finishQuestions:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
        make.height.equalTo(@40);
        make.top.equalTo(self.contentView).offset(850);
    }];
}

-(void)finishQuestions:(id)sender{

    NSArray *answers = [self createAnswersArray];
    
    [SVProgressHUD showWithStatus:@"正在提交问卷结果"];
    [NetworkManager uploadSatisfiedQuestionAnswers:answers WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"satisfied_quesitons"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"satisfied_quesitons"];

        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
}

-(NSArray *)createAnswersArray{
    NSMutableArray *arr = [NSMutableArray array];
    switch (self.firstpage_answer1) {
        case 0:
        {
            arr[0] = @"满意";
        }
            break;
            
        case 1:
        {
             arr[0] = @"比较满意";
        }
            break;
            
        case 2:
        {
             arr[0] = @"一般";
        }
            break;
            
        case 3:
        {
             arr[0] = @"不满意";
        }
            break;
    }
    
    switch (self.firstpage_answer2) {
        case 0:
        {
            arr[1] = @"满意";
        }
            break;
            
        case 1:
        {
            arr[1] = @"比较满意";
        }
            break;
            
        case 2:
        {
            arr[1] = @"一般";
        }
            break;
            
        case 3:
        {
            arr[1] = @"不满意";
        }
            break;
    }
    NSString *answerThreeString = [NSString string];
    if (self.firstpage_answer3_1) {
        answerThreeString =[answerThreeString stringByAppendingString:@"简化操作过程;"];
    }
    if (self.firstpage_answer3_2) {
        answerThreeString =[answerThreeString stringByAppendingString:@"提高准确度;"];
    }
    if (self.firstpage_answer3_3) {
        answerThreeString = [answerThreeString stringByAppendingString:self.firstpage_otherString1];
    }
    
    arr[2] = answerThreeString;
    
    switch (self.secondpage_answer1) {
        case 0:
        {
            arr[3] = @"满意";
        }
            break;
            
        case 1:
        {
            arr[3] = @"比较满意";
        }
            break;
            
        case 2:
        {
            arr[3] = @"一般";
        }
            break;
            
        case 3:
        {
            arr[3] = @"不满意";
        }
            break;
    }
    
    switch (self.secondpage_answer2) {
        case 0:
        {
            arr[4] = @"满意";
        }
            break;
            
        case 1:
        {
            arr[4] = @"比较满意";
        }
            break;
            
        case 2:
        {
            arr[4] = @"一般";
        }
            break;
            
        case 3:
        {
            arr[4] = @"不满意";
        }
            break;
    }
    
    switch (self.secondpage_answer3) {
        case 0:
        {
            arr[5] = @"不需要";
        }
            break;
            
        case 1:
        {
            arr[5] = @"增加更多管理选择";
        }
            break;
            
        case 2:
        {
            arr[5] = @"减少目前的管理选择";
        }
            break;
    }
    
    
    
    switch (self.thirdpage_answer1) {
        case 0:
        {
            arr[6] = @"更多的美白信息";
        }
            break;
            
        case 1:
        {
            arr[6] = @"（网上商城）能够直接购买美白产品";
        }
            break;
            
        case 2:
        {
            arr[6] = @"（网上商城）能够购买其他保健产品";
        }
            break;
            
        case 3:
        {
            arr[6] = self.thirdpage_string1;
        }
            break;
    }
    
    switch (self.thirdpage_answer2) {
        case 0:
        {
            arr[7] = @"希望";
        }
            break;
            
        case 1:
        {
            arr[7] = @"不希望";
        }
            break;
            
        case 2:
        {
            arr[7] = @"无所谓";
        }
            break;
    }
    switch (self.thirdpage_answer3) {
        case 0:
        {
            arr[8] = @"口腔健康";
        }
            break;
            
        case 1:
        {
            arr[8] = @"口腔疾病治疗";
        }
            break;
            
        case 2:
        {
            arr[8] = self.thirdpage_string3;
        }
            break;
    }
    
    switch (self.thirdpage_answer4) {
        case 0:
        {
            arr[9] = @"非常需要";
        }
            break;
            
        case 1:
        {
            arr[9] = @"一般";
        }
            break;
            
        case 2:
        {
            arr[9] =@"不太需要";
        }
            break;
    }
    
    
    
    
    
    
    return arr;
    
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


@end
