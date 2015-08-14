//
//  QuestionFiveViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionFiveViewController.h"
#import "Utils.h"
#import "RS_SliderView.h"
#import <Masonry.h>
#import "TeethStateConfigureFile.h"
#import "QuestionsConfigFile.h"
#import "QuestionAnalysizeController.h"


@interface QuestionFiveViewController ()<RSliderViewDelegate>
@property (nonatomic, strong) RS_SliderView *horSlider;
@property (nonatomic, strong) UILabel *yesLabel;

@property (nonatomic, strong) UILabel *noLabel;
@property (nonatomic, assign) BOOL isStrongWill;

@end

@implementation QuestionFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"问卷" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
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
    
    _yesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _yesLabel.textColor = [Utils commonColor];
    _yesLabel.text = @"很强,希望马上实现";
    
    [self.view addSubview:_yesLabel];
    
    [_yesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.left.equalTo(self.horSlider.mas_left).offset(0);
        make.right.equalTo(self.horSlider.mas_centerX).offset(0);
        make.height.equalTo(@30);
    }];
    
    _noLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _noLabel.textColor = [UIColor lightGrayColor];
    _noLabel.textAlignment = NSTextAlignmentRight;
    _noLabel.text = @"还好,等几天也可以";
    
    [self.view addSubview:_noLabel];
    
    [_noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.right.equalTo(self.horSlider.mas_right).offset(0);
        make.left.equalTo(self.horSlider.mas_centerX).offset(0);
        make.height.equalTo(@30);
    }];
    
    self.isStrongWill = YES;
}
-(void)sliderValueChanged:(RS_SliderView *)sender {
    if (sender.value < 0.5) {
        self.yesLabel.textColor = [Utils commonColor];
        self.noLabel.textColor = [UIColor lightGrayColor];
        [TeethStateConfigureFile WillStrong:YES];
        
    } else{
        self.yesLabel.textColor = [UIColor lightGrayColor];
        self.noLabel.textColor = [Utils commonColor];
        [TeethStateConfigureFile WillStrong:NO];
    }
}

-(void)sliderValueChangeEnded:(RS_SliderView *)sender {
    
    if (sender.value < 0.5) {
        [sender setValue:0.0 withAnimation:YES completion:^(BOOL finished) {

        }];
    } else{
        [sender setValue:1.0 withAnimation:YES completion:^(BOOL finished) {
        }];
    }
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

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)completedQuestions:(id)sender {
    [QuestionsConfigFile setCompletedInitialQuestions:YES];
    
    //牙齿等级

    NSInteger answer1 = [TeethStateConfigureFile teethLevel];
    
    
    NSInteger answer2 = 0;
    // 是否敏感
    BOOL issensitive = [TeethStateConfigureFile isSensitive];
    
    if (issensitive) {
        answer2 = 0;
    } else{
        answer2 = 1;

    }
    NSInteger answer3 = 0;
    //是否意愿强烈
    BOOL willstrong = [TeethStateConfigureFile isWillStrong];
    
    if (willstrong) {
        answer3 = 0;
    } else{
        answer3 = 1;
    }
    
    if (answer1 == 0 && answer2 == 1 && answer3 == 0) {
        //加强
        
        //分析结果跳转至相应界面
        
        QuestionAnalysizeController *analysizeVC = [[QuestionAnalysizeController alloc] initWithNibName:@"QuestionAnalysizeController" bundle:nil];
        analysizeVC.type = Enhance;
        [self.navigationController pushViewController:analysizeVC animated:YES];

        
    } else if(answer1 == 2){
        //咨询牙医
        
    } else if(answer1 != 2 && answer2 == 0 && answer3 == 1){
        //温柔计划
        //分析结果跳转至相应界面
        
        QuestionAnalysizeController *analysizeVC = [[QuestionAnalysizeController alloc] initWithNibName:@"QuestionAnalysizeController" bundle:nil];
        analysizeVC.type = Gentle;

        [self.navigationController pushViewController:analysizeVC animated:YES];

    } else{
        //标准
        //分析结果跳转至相应界面
        
        QuestionAnalysizeController *analysizeVC = [[QuestionAnalysizeController alloc] initWithNibName:@"QuestionAnalysizeController" bundle:nil];
        analysizeVC.type = Standard;

        [self.navigationController pushViewController:analysizeVC animated:YES];

    }
    
    
    
    
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];

}


@end
