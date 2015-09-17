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

#import "QuestionOneView.h"
#import "SatisfiedTwoViewController.h"


@interface SatisfiedOneViewController ()<UITextViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextView *textView;



@property (nonatomic,strong) NSMutableArray *oneViewArrays;
@property (nonatomic,strong) NSMutableArray *twoViewArrays;
@property (nonatomic,strong) NSMutableArray *threeViewArrays;


@property (nonatomic,assign) NSInteger answer1;
@property (nonatomic,assign) NSInteger answer2;


@property (nonatomic, assign) BOOL answer3_1;
@property (nonatomic, assign) BOOL answer3_2;
@property (nonatomic, assign) BOOL answer3_3;


@property (nonatomic,strong) NSString *otherString;




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
    [self.view addSubview:arrowView];
    
    
    
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@40);
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    arrowImageView.image = [UIImage imageNamed:@"quesiton_once_arrow0"];
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
        make.height.equalTo(@900);
    }];
    
    //第一题
    [self configFirstQuestionView];
    //第二题
    [self configSecondQuestionView];
    //第三题
    [self configThirdQuestionView];
    
    [self configNextButton];

    
}

//第1题相关

-(void)configFirstQuestionView{
    
    UILabel * question1 = [[UILabel alloc] initWithFrame:CGRectZero];
    question1.textColor = [UIColor blackColor];
    question1.text = @"Q1:请问您对测白的操作过程满意吗?";
    
    [self.contentView addSubview:question1];
    
    [question1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@30);
    }];
    //
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
    
    self.answer1 = 0;
    
}
//第2题相关

-(void)configSecondQuestionView{
    
    UILabel * question2 = [[UILabel alloc] initWithFrame:CGRectZero];
    question2.textColor = [UIColor blackColor];
    question2.text = @"Q2:请问您对测白的结果显示满意吗?";
    
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
    
    self.answer2 = 0;

    
}

//第三题
-(void)configThirdQuestionView{
    UILabel * question3 = [[UILabel alloc] initWithFrame:CGRectZero];
    question3.textColor = [UIColor blackColor];
    question3.numberOfLines = 0;
    question3.text = @"Q3:您希望测白过程需要什么样的改进?";
    
    [self.contentView addSubview:question3];
    
    [question3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(380);
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
            make.top.equalTo(self.contentView).offset(420 + i * 40);
            if ([Utils isiPhone4]) {
                make.height.equalTo(@25);
                make.top.equalTo(self.contentView).offset(250 + i * 30);
            }
        }];
    }
    
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(550);
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.width.equalTo(@200);
        make.height.equalTo(@60);
    }];
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.keyboardType=  UIKeyboardAppearanceDefault;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    self.otherString = textView.text;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.answer3_3 == YES) {
        return YES;
    } else{
        return NO;
    }
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
    
    self.answer1 = tap.view.tag;
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
    
    self.answer2 = tap.view.tag;

}
-(void)selectIndex3:(UITapGestureRecognizer *)tap{
    
    QuestionOneView *view = self.threeViewArrays[tap.view.tag];
    
    switch (tap.view.tag) {
        case 0:
        {
            if (self.answer3_1 == YES) {
                self.answer3_1 = NO;
                [view didSelectionAtIndex:Normal];
            } else{
                self.answer3_1 = YES;
                [view didSelectionAtIndex:Selected];
            }
        }
            break;
        case 1:
        {
            if (self.answer3_2 == YES) {
            self.answer3_2 = NO;
            [view didSelectionAtIndex:Normal];
        } else{
            self.answer3_2 = YES;
            [view didSelectionAtIndex:Selected];
        }
            
        }
            break;
        case 2:
        {
            if (self.answer3_3 == YES) {
                self.answer3_3 = NO;
                [view didSelectionAtIndex:Normal];
                self.textView.text = nil;
                [self.textView resignFirstResponder];
            } else{
                self.answer3_3 = YES;
                [view didSelectionAtIndex:Selected];
            }
        }
            break;
            
        default:
            break;
    }
    
}

-(void)configNextButton{
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:nextButton];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(twoQuestion:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(50);
        make.right.equalTo(self.contentView.mas_right).offset(-50);
        make.height.equalTo(@40);
        make.top.equalTo(self.contentView).offset(660);
    }];
}

-(void)twoQuestion:(id)sender{
    
    
    if (self.answer3_1 == NO && self.answer3_2 == NO && self.answer3_3 == NO
        
        ) {
        //提示选择
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请完善相关问卷,再进行一下步操作吧" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else if(self.answer3_1 == NO && self.answer3_2 == NO && self.answer3_3 == YES && self.otherString == nil){
        //提示选择
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请完善相关问卷,再进行一下步操作吧" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else{
        SatisfiedTwoViewController *twoVC = [[SatisfiedTwoViewController alloc] initWithNibName:@"SatisfiedTwoViewController" bundle:nil];
        twoVC.firstpage_answer1 = self.answer1;
        twoVC.firstpage_answer2 = self.answer2;
        twoVC.firstpage_answer3_1 = self.answer3_1;
        twoVC.firstpage_answer3_2 = self.answer3_2;
        twoVC.firstpage_answer3_3 = self.answer3_3;
        twoVC.firstpage_otherString1 = self.otherString;
        
        [self.navigationController pushViewController:twoVC animated:NO];
    }
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
