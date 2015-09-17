//
//  QuestionThreeViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionThreeViewController.h"
#import "Utils.h"
#import "RS_SliderView.h"
#import <Masonry.h>
#import "TeethStateConfigureFile.h"


@interface QuestionThreeViewController ()<RSliderViewDelegate>

@property (nonatomic, strong) RS_SliderView *horSlider;

@property (nonatomic,strong) UILabel *goodLabel;
@property (nonatomic,strong) UILabel *normalLabel;
@property (nonatomic,strong) UILabel *badLabel;
@property (nonatomic,strong) UILabel *unknownLabel;


@end

@implementation QuestionThreeViewController

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
    
    
    _goodLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _goodLabel.textColor = [Utils commonColor];
    _goodLabel.text = @"好";
    
    [self.view addSubview:_goodLabel];
    
    [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.left.equalTo(self.horSlider.mas_left).offset(0);
        make.width.equalTo(@20);
        make.height.equalTo(@30);
    }];
    
    _normalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _normalLabel.textColor = [UIColor lightGrayColor];
    _normalLabel.text = @"一般";
    
    [self.view addSubview:_normalLabel];
    
    [_normalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.centerX.equalTo(self.horSlider.mas_centerX).multipliedBy(0.5).offset(20);
        make.width.equalTo(@40);
        make.height.equalTo(@30);
    }];
    _badLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _badLabel.textColor = [UIColor lightGrayColor];
    _badLabel.text = @"不好";
    
    [self.view addSubview:_badLabel];
    
    [_badLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.centerX.equalTo(self.horSlider.mas_right).multipliedBy(0.75).offset(-20);
        make.width.equalTo(@40);
        make.height.equalTo(@30);
    }];

    _unknownLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _unknownLabel.textColor = [UIColor lightGrayColor];
    _unknownLabel.text = @"不知道";
    
    [self.view addSubview:_unknownLabel];
    
    [_unknownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.horSlider.mas_bottom).offset(8);
        make.right.equalTo(self.horSlider.mas_right).offset(0);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];

    [TeethStateConfigureFile setTeethStateLevel:0];
    
    NSInteger level = [TeethStateConfigureFile teethLevel];
    
    NSLog(@"level %ld",level);

}

-(void)sliderValueChanged:(RS_SliderView *)sender {
    
    if (sender.value < 0.25) {
        self.goodLabel.textColor = [Utils commonColor];
        self.badLabel.textColor = [UIColor lightGrayColor];
        self.normalLabel.textColor = [UIColor lightGrayColor];
        self.unknownLabel.textColor = [UIColor lightGrayColor];
        
    } else if (sender.value >= 0.25 && sender.value < 0.5){
        
        self.goodLabel.textColor =  [UIColor lightGrayColor];
        self.badLabel.textColor = [UIColor lightGrayColor];
        self.normalLabel.textColor = [Utils commonColor];
        self.unknownLabel.textColor = [UIColor lightGrayColor];
        
    }else if (sender.value >= 0.5 && sender.value < 0.75){
        self.goodLabel.textColor =  [UIColor lightGrayColor];
        self.badLabel.textColor = [Utils commonColor];
        self.normalLabel.textColor = [UIColor lightGrayColor];
        self.unknownLabel.textColor = [UIColor lightGrayColor];
    } else{
        self.goodLabel.textColor =  [UIColor lightGrayColor];
        self.badLabel.textColor = [UIColor lightGrayColor];
        self.normalLabel.textColor = [UIColor lightGrayColor];
        self.unknownLabel.textColor = [Utils commonColor];
    }
}

-(void)sliderValueChangeEnded:(RS_SliderView *)sender {
    
    if (sender.value >= 0.0 && sender.value < 0.25) {
        [sender setValue:0.0 withAnimation:YES completion:^(BOOL finished) {
            [TeethStateConfigureFile setTeethStateLevel:0];
            
            NSInteger level = [TeethStateConfigureFile teethLevel];
            
            NSLog(@"level %ld",level);
            
        }];
    } else if (sender.value >= 0.25 && sender.value < 0.5){
        [sender setValue:0.33 withAnimation:YES completion:^(BOOL finished) {
            [TeethStateConfigureFile setTeethStateLevel:1];
            NSInteger level = [TeethStateConfigureFile teethLevel];
            
            NSLog(@"level %ld",level);

        }];
    }else if (sender.value >= 0.5 && sender.value < 0.75){
        [sender setValue:0.66 withAnimation:YES completion:^(BOOL finished) {
            [TeethStateConfigureFile setTeethStateLevel:2];
            NSInteger level = [TeethStateConfigureFile teethLevel];
            
            NSLog(@"level %ld",level);

        }];
    }else{
        [sender setValue:1.0 withAnimation:YES completion:^(BOOL finished) {
            [TeethStateConfigureFile setTeethStateLevel:3];
            NSInteger level = [TeethStateConfigureFile teethLevel];
            
            NSLog(@"level %ld",level);

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
    [self.navigationController popViewControllerAnimated:NO];

}

@end
