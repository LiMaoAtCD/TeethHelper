//
//  MeiBaiViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiViewController.h"
#import "Utils.h"
#import "ProductIntroduceViewController.h"

@interface MeiBaiViewController ()

@end

@implementation MeiBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];
    
    
    //产品介绍
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"产品介绍" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickProductIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //
}

-(void)clickProductIntroduce:(UIButton *)button {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    ProductIntroduceViewController *introduceVC =[sb instantiateViewControllerWithIdentifier:@"ProductIntroduceViewController"];
    
    introduceVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController showViewController:introduceVC sender:self];
    
    
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
