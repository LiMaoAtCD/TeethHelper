//
//  SocialViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialViewController.h"
#import "Utils.h"
#import "SocialImageCell.h"
#import "SocialNoImageCell.h"
#import <DateTools.h>
@interface SocialViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataItems;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"社区" onViewController:self];
    self.navigationItem.leftBarButtonItem = nil;
    
    self.dataItems = [NSMutableArray array];

    self.dataItems =[@[
                       @{@"avatar":@"xxx",
                         @"time":@"2015-01-01",
                         @""
                         }
                       
                       ] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
