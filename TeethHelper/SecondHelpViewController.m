//
//  SecondHelpViewController.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/19.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "SecondHelpViewController.h"
#import "Utils.h"

@interface SecondHelpViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation SecondHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"测白说明" onViewController:self];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview:_scrollView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:_imageView];
    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        self.scrollView.contentSize = CGSizeMake(320, 3259.0 / 2);

        
        self.imageView.image = [UIImage imageNamed:@"useGuide_5"];
        self.imageView.frame = CGRectMake(0, 0, 320, 3259.0 / 2);
        
        
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        self.scrollView.contentSize = CGSizeMake(375, 3819.0 / 2);

        self.imageView.image = [UIImage imageNamed:@"useGuide_6"];
        self.imageView.frame = CGRectMake(0, 0, 375, 3819.0 / 2);

    } else {
        
        self.scrollView.contentSize = CGSizeMake(1242.0 /3, 6324.0 / 3);

        self.imageView.image = [UIImage imageNamed:@"useGuide_6p"];
        self.imageView.frame = CGRectMake(0, 0, 1242.0 /3, 6324.0 / 3);

    }
    
    
    
}

-(void)pop {
    [self.navigationController popViewControllerAnimated:YES];
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
