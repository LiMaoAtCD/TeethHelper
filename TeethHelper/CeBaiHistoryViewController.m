//
//  CeBaiHistoryViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "CeBaiHistoryViewController.h"
#import "CeBaiHistoryCell.h"
#import "Utils.h"


@interface CeBaiHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CeBaiHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    
    [Utils ConfigNavigationBarWithTitle:@"测白记录" onViewController:self];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CeBaiHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CeBaiHistoryCell" forIndexPath:indexPath];
    
    if (indexPath.row != 0) {
        cell.topLine.hidden = YES;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    view.backgroundColor = [UIColor colorWithRed:214./255 green:225./255 blue:230./255 alpha:1.0];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width / 2, view.bounds.size.height)];
    time.text = @"时 间";
    time.textColor = [UIColor grayColor];
    time.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:time];
    
    
    
    UILabel *times = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width / 2, 0, view.bounds.size.width / 2, view.bounds.size.height)];
    times.text = @"测白结果";
    times.textColor = [UIColor grayColor];
    times.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:times];
    

    return view;

    
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
