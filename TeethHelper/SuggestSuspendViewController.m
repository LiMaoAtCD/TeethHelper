//
//  SuggestSuspendViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/31.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SuggestSuspendViewController.h"
#import "Utils.h"
@interface SuggestSuspendViewController ()

@end

@implementation SuggestSuspendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"反馈结果" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
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
