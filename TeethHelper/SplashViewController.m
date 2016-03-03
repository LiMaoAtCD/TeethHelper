//
//  SplashViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SplashViewController.h"
#import <Masonry.h>
@interface SplashViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *splashView;


@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat screenWidth =[UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight =[UIScreen mainScreen].bounds.size.height;
    
    self.splashView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.splashView.pagingEnabled = YES;
    self.splashView.bounces = NO;
    self.splashView.delegate = self;
    self.splashView.showsVerticalScrollIndicator= NO;
    self.splashView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.splashView];
    
    [self.splashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.splashView.contentSize = CGSizeMake(screenWidth * 4, 1);
    
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i * screenWidth, 0, screenWidth, screenHeight)];
        imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"splash_%d",i+1]];
        [self.splashView addSubview:imageview];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(endSplash:) forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(3.5 * screenWidth - 100, screenHeight - 150, 200, 100);
    [button setTitle:@"立即开启" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [self.splashView addSubview:button];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)endSplash:(id)sender{
//    [UIView animateWithDuration:0.3 animations:^{
////        self.view.transform = CGAffineTransformMakeScale(2.0, 2.0);
//        self.view.alpha = 0.5;
//    } completion:^(BOOL finished) {
//        [self dismissViewControllerAnimated:NO completion:nil];
    
//    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login_vc" object:nil];
    
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
