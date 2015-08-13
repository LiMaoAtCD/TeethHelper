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

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

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
    
    self.splashView.contentSize = CGSizeMake(screenWidth * 3, 1);
    
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i * screenWidth, 0, screenWidth, screenHeight)];
        imageview.image = [UIImage imageNamed:@"temp"];
        [self.splashView addSubview:imageview];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(endSplash:) forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(2.5 * screenWidth - 50, screenHeight  - 100, 100, 50);
    
    button.backgroundColor = [UIColor redColor];
    [self.splashView addSubview:button];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat screenWidth =[UIScreen mainScreen].bounds.size.width;

    if (scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x < screenWidth) {
        self.pageControl.currentPage = 0;
    } else if(scrollView.contentOffset.x >= screenWidth && scrollView.contentOffset.x < 2 * screenWidth){
        self.pageControl.currentPage = 1;

    } else{
        self.pageControl.currentPage = 2;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)endSplash:(id)sender{
    [UIView animateWithDuration:1.0 animations:^{
        self.view.transform = CGAffineTransformMakeScale(2.0, 2.0);
        self.view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
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
