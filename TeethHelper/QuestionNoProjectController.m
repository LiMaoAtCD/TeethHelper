//
//  QuestionNoProjectController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionNoProjectController.h"
#import "Utils.h"
#import "MeiBaiConfigFile.h"
#import "FirstCeBaiViewController.h"

@interface QuestionNoProjectController ()

@end

@implementation QuestionNoProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白计划" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    //设置美白等级为3
//    [MeiBaiConfigFile setCureTimesEachDay:3];
//    [MeiBaiConfigFile setNeedCureDays:10];
    [MeiBaiConfigFile setCurrentProject:GENTLE_NoNotification];
    
}
-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goCeBai:(id)sender {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"QuestionsCompleted" object:nil];
    
    FirstCeBaiViewController * first = [[FirstCeBaiViewController alloc] initWithNibName:@"FirstCeBaiViewController" bundle:nil];;
    
    [self.navigationController pushViewController:first animated:YES];

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
