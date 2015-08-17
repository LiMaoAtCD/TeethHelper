//
//  ProjectCompletedQuesitonController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/17.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ProjectCompletedQuesitonController.h"
#import <Masonry.h>
#import "QuestionOneView.h"
#import "Utils.h"
#import "RS_SliderView.h"

@interface ProjectCompletedQuesitonController ()<RSliderViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *questionIndexImageView;

//
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *finishedButton;
@property (nonatomic, strong) UILabel *questionLabel;

//第一题
@property (nonatomic,strong) NSMutableArray *oneViewArrays;

//第二题的
@property (nonatomic, strong) RS_SliderView *horSlider;
@property (nonatomic, strong) UILabel *firstAnswerLabel;
@property (nonatomic, strong) UILabel *secondAnswerLabel;
@property (nonatomic, strong) UILabel *thirdAnswerLabel;

@end

@implementation ProjectCompletedQuesitonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    
    _questionIndexImageView.image = [UIImage imageNamed:@"MB_completed_question1"];
    
    _questionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _questionLabel.textColor = [UIColor blackColor];
    _questionLabel.text = @"Q1:您本次美白共持续了多长时间?";
    
    [self.view addSubview:_questionLabel];
    
    [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(230);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@30);
    }];
    
    
    [self configFirstQuestionView];
    
}

//第1题相关

-(void)configFirstQuestionView{
    NSArray *labels = @[@"3次共24分钟",@"4次共24分钟",@"5次共24分钟",@"6次共24分钟",@"7次共24分钟"];
    self.oneViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
        //        view.backgroundColor = [UIColor redColor];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.view addSubview:view];
        [self.oneViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@200);
            make.left.equalTo(self.view.mas_left).offset(50);
            make.height.equalTo(@30);
            make.top.equalTo(self.view).offset(290 + i * 40);
            if ([Utils isiPhone4]) {
                make.height.equalTo(@25);
                make.top.equalTo(self.view).offset(250 + i * 30);
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

}

//第二题相关
-(void)configSecondQuestionView{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _horSlider = [[RS_SliderView alloc] initWithFrame:CGRectMake(10, 240, width - 20, 25) andOrientation:Horizontal];
    _horSlider.delegate = self;
    
    [_horSlider setColorsForBackground:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]
                            foreground:[UIColor colorWithRed:68./255.0 green:164.0/255.0 blue:167.0/255.0 alpha:1.0]
                                handle:[UIColor colorWithRed:136.0/255.0 green:255.0/255.0 blue:254.0/255.0 alpha:1.0]
                                border:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]];
    [self.view addSubview:_horSlider];
    
    [_horSlider setValue:0.0 withAnimation:YES completion:^(BOOL finished) {
        
    }];
    [_horSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-150);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@25);
    }];
    
    
    //第一答案
    _firstAnswerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _firstAnswerLabel.textColor = [Utils commonColor];
    _firstAnswerLabel.text = @"无";
    [self.view addSubview:_firstAnswerLabel];
    [_firstAnswerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.left.equalTo(self.horSlider.mas_left).offset(20);
        make.width.equalTo(@40);
        make.height.equalTo(@30);
    }];
    
    //第二答案
    _secondAnswerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _secondAnswerLabel.textColor = [UIColor lightGrayColor];
    _secondAnswerLabel.text = @"轻微酸痛感";
    
    [self.view addSubview:_secondAnswerLabel];
    
    
    [_secondAnswerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.center.equalTo(self.horSlider.mas_centerX).offset(0);
        make.width.equalTo(self.horSlider.mas_width).multipliedBy(0.3);
        make.height.equalTo(@30);
    }];
     //第三答案
    _thirdAnswerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _thirdAnswerLabel.textColor = [UIColor lightGrayColor];
    _thirdAnswerLabel.textAlignment = NSTextAlignmentRight;
    _thirdAnswerLabel.text = @"严重酸痛感";
    
    [self.view addSubview:_thirdAnswerLabel];
    
    [_thirdAnswerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.right.equalTo(self.horSlider.mas_right).offset(0);
        make.width.equalTo(self.horSlider.mas_width).multipliedBy(0.3);
        make.height.equalTo(@30);
    }];


}

-(void)sliderValueChanged:(RS_SliderView *)sender {
    if (sender.value < 0.33) {
        self.firstAnswerLabel.textColor = [Utils commonColor];
        self.secondAnswerLabel.textColor = [UIColor lightGrayColor];
        self.thirdAnswerLabel.textColor = [UIColor lightGrayColor];
    } else if(sender.value >= 0.33 && sender.value < 0.67){
        self.firstAnswerLabel.textColor = [UIColor lightGrayColor];
        self.secondAnswerLabel.textColor = [Utils commonColor];
        self.thirdAnswerLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.firstAnswerLabel.textColor = [UIColor lightGrayColor];
        self.secondAnswerLabel.textColor = [UIColor lightGrayColor];
        self.thirdAnswerLabel.textColor = [Utils commonColor];
    }
    
}

-(void)sliderValueChangeEnded:(RS_SliderView *)sender {
    
    if (sender.value <  0.33) {
        [sender setValue:0.0 withAnimation:YES completion:^(BOOL finished) {
        }];
    } else if(sender.value >= 0.33 && sender.value < 0.67){
        [sender setValue:0.5 withAnimation:YES completion:^(BOOL finished) {
        }];
    }else{
        [sender setValue:1.0 withAnimation:YES completion:^(BOOL finished) {
        }];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击事件处理

-(void)nextQuestion:(UIButton *)button{
    _questionLabel.text = @"Q2:请问您在牙齿美白中有酸痛感觉吗?";

    self.questionIndexImageView.image = [UIImage imageNamed:@"MB_completed_question2"];
    self.nextButton.hidden = YES;
    self.previousButton.hidden = NO;
    self.finishedButton.hidden = NO;
    
    [self.oneViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *oneView = obj;
        [oneView removeFromSuperview];
    }];
    
    [self configSecondQuestionView];

}

-(void)previousQuestion:(UIButton*)button{
    
    _questionLabel.text = @"Q1:您本次美白共持续了多长时间?";

    self.questionIndexImageView.image = [UIImage imageNamed:@"MB_completed_question1"];
    self.nextButton.hidden = NO;
    self.previousButton.hidden = YES;
    self.finishedButton.hidden = YES;
    
    [self.horSlider removeFromSuperview];
    [self.firstAnswerLabel removeFromSuperview];
    [self.secondAnswerLabel removeFromSuperview];
    [self.thirdAnswerLabel removeFromSuperview];

    [self configFirstQuestionView];
}

-(void)finishQuesiton:(UIButton*)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
