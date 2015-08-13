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
@interface QuestionTwoViewController ()<RSliderViewDelegate>

@end

@implementation QuestionTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"问卷" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];

    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    RS_SliderView *horSlider = [[RS_SliderView alloc] initWithFrame:CGRectMake(10, 240, width - 20, 25) andOrientation:Horizontal];
    horSlider.delegate = self;
    
    [horSlider setColorsForBackground:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]
                           foreground:[UIColor colorWithRed:68./255.0 green:164.0/255.0 blue:167.0/255.0 alpha:1.0]
                               handle:[UIColor colorWithRed:136.0/255.0 green:255.0/255.0 blue:254.0/255.0 alpha:1.0]
                               border:[UIColor colorWithRed:168.0/255.0 green:168.0/255.0 blue:168.0/255.0 alpha:1.0]];
    [self.view addSubview:horSlider];
    
    
//    [horSlider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.
//    }];


}

-(void)sliderValueChanged:(RS_SliderView *)sender {
    NSLog(@"Value Changed: %f", sender.value);
}

-(void)sliderValueChangeEnded:(RS_SliderView *)sender {
    NSLog(@"Touсh ended: %f", sender.value);
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
    [self.navigationController popViewControllerAnimated:YES];

}


@end
