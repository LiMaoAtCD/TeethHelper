//
//  UseHistoryViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "UseHistoryViewController.h"
#import "UseHistoryCell.h"
#import "Utils.h"

#import <Masonry.h>

@interface UseHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *useHistoryItems;

@end

@implementation UseHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"使用记录" onViewController:self];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.useHistoryItems.count;
    return 4;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UseHistoryCell" forIndexPath:indexPath];
    if (indexPath.row != 0) {
        cell.topLine.hidden = YES;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    view.backgroundColor = [UIColor colorWithRed:214./255 green:225./255 blue:230./255 alpha:1.0];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width / 3, view.bounds.size.height)];
    time.text = @"时 间";
    time.textColor = [UIColor grayColor];
    time.textAlignment = NSTextAlignmentCenter;

    [view addSubview:time];
    

    
    UILabel *times = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width / 3, 0, view.bounds.size.width / 3, view.bounds.size.height)];
    times.text = @"使用次数";
    times.textColor = [UIColor grayColor];
    times.textAlignment = NSTextAlignmentCenter;

    [view addSubview:times];
    

    
    
    UILabel *meibaiTime = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width * 2 / 3, 0, view.bounds.size.width / 3, view.bounds.size.height)];
    meibaiTime.text = @"美白时间";
    meibaiTime.textColor = [UIColor grayColor];
    meibaiTime.textAlignment = NSTextAlignmentCenter;
    [view addSubview:meibaiTime];


    
    
    return view;
    
    
}

@end
