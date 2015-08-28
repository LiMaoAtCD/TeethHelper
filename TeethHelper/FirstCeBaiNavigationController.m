//
//  FirstCeBaiNavigationController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/28.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "FirstCeBaiNavigationController.h"
#import "FirstCeBaiViewController.h"
@interface FirstCeBaiNavigationController ()


@end

@implementation FirstCeBaiNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FirstCeBaiViewController *first = [[FirstCeBaiViewController alloc] initWithNibName:@"FirstCeBaiViewController" bundle:nil];
    [self pushViewController:first animated:NO];
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
