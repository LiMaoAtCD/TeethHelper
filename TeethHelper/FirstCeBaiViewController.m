//
//  FirstCeBaiViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/27.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "FirstCeBaiViewController.h"
#import "CameraViewController.h"
#import "ImageEditViewController.h"
#import "Utils.h"
#import "SecondHelpViewController.h"


@interface FirstCeBaiViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FirstCeBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
    UIButton *rightHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightHelpButton setTitle:@"帮助" forState:UIControlStateNormal];
    
    [rightHelpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    rightHelpButton.frame = CGRectMake(0, 0, 60, 35);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightHelpButton];
    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        
        
        self.imageView.image = [UIImage imageNamed:@"cebai_5"];
        self.imageView.frame = CGRectMake(0, 0, 320, 820.0 / 2);
        
        
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        
        self.imageView.image = [UIImage imageNamed:@"cebai_6"];
        self.imageView.frame = CGRectMake(0, 0, 375, 1018.0 / 2);
    } else {
        
        
        self.imageView.image = [UIImage imageNamed:@"cebai_7"];
        self.imageView.frame = CGRectMake(0, 0, 1242. / 3, 1734.0 / 3);
        
        
    }
}

-(void)help{
    SecondHelpViewController *second = [[SecondHelpViewController alloc] initWithNibName:@"SecondHelpViewController" bundle:nil];
    second.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:second animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;

}

- (IBAction)gotoCebai:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController *cameraVC = [sb instantiateViewControllerWithIdentifier:@"CameraViewController"];
//    cameraVC.delegate = self;
    cameraVC.hidesBottomBarWhenPushed = YES;
    //    [self showDetailViewController:cameraVC sender:self];
    [self.navigationController pushViewController:cameraVC animated:YES];
    
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
