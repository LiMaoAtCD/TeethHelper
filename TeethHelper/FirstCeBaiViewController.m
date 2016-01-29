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


@interface FirstCeBaiViewController ()

@end

@implementation FirstCeBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
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
