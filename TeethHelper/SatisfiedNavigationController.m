//
//  SatisfiedNavigationController.m
//  TeethHelper
//
//  Created by AlienLi on 15/9/16.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SatisfiedNavigationController.h"
#import "SatisfiedOneViewController.h"


@interface SatisfiedNavigationController ()

@end

@implementation SatisfiedNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SatisfiedOneViewController *oneVC = [[SatisfiedOneViewController alloc] initWithNibName:@"SatisfiedOneViewController" bundle:nil];
    
    [self pushViewController:oneVC animated:NO];
    
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
