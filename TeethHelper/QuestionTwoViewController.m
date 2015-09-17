//
//  QuestionTwoViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionTwoViewController.h"
#import "Utils.h"
#import "RS_SliderView.h"
#import <Masonry.h>
#import "TeethStateConfigureFile.h"
#import "AccountManager.h"

@interface QuestionTwoViewController ()<RSliderViewDelegate>

@property (nonatomic, strong) UILabel *maleLabel;

@property (nonatomic, strong) UILabel *femaleLabel;

@property (nonatomic, strong) RS_SliderView *horSlider;

@property (nonatomic, assign) BOOL isMale;


@end

@implementation QuestionTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"问卷" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];

    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _horSlider = [[RS_SliderView alloc] initWithFrame:CGRectMake(10, 300, width - 20, 25) andOrientation:Horizontal];
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
    
    _maleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _maleLabel.textColor = [Utils commonColor];
    _maleLabel.text = @"男";
    
    [self.view addSubview:_maleLabel];
    
    [_maleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.left.equalTo(self.horSlider.mas_left).offset(20);
        make.width.equalTo(@40);
        make.height.equalTo(@30);
    }];
    
    _femaleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _femaleLabel.textColor = [UIColor lightGrayColor];
    _femaleLabel.textAlignment = NSTextAlignmentRight;
    _femaleLabel.text = @"女";
    
    [self.view addSubview:_femaleLabel];
    
    [_femaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.right.equalTo(self.horSlider.mas_right).offset(-20);
        make.width.equalTo(@40);
        make.height.equalTo(@30);
    }];

    self.isMale = YES;
    
    [TeethStateConfigureFile setGender:0];

    [AccountManager setgender:@"男"];
    
}

-(void)sliderValueChanged:(RS_SliderView *)sender {
    
    if (sender.value < 0.5) {
        self.maleLabel.textColor = [Utils commonColor];
        self.femaleLabel.textColor = [UIColor lightGrayColor];
        self.isMale = YES;

    } else{
        self.maleLabel.textColor = [UIColor lightGrayColor];
        self.femaleLabel.textColor = [Utils commonColor];
        self.isMale = NO;
    }
}

-(void)sliderValueChangeEnded:(RS_SliderView *)sender {
    
    if (sender.value > 0.5) {
        [TeethStateConfigureFile setGender:1];
        [AccountManager setgender:@"女"];

        [sender setValue:1.0 withAnimation:YES completion:^(BOOL finished) {
        }];
    } else{
        [TeethStateConfigureFile setGender:0];
        [AccountManager setgender:@"男"];

        [sender setValue:0.0 withAnimation:YES completion:^(BOOL finished) {
            
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];

}


@end
