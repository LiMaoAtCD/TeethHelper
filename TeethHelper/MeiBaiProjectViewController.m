//
//  MeiBaiProjectViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeiBaiProjectViewController.h"
#import "MeiBaiOneCell.h"
#import "MeiBaiTwoCell.h"
#import "MeiBaiConfigFile.h"
#import "Utils.h"
@interface MeiBaiProjectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MeiBaiProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"美白计划" onViewController:self];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if(section == 1){
        return 2;
    } else{
        return 1;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MeiBaiOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeiBaiOneCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"启用保持计划";
        
        return cell;
        
    } else{
        MeiBaiTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeiBaiTwoCell" forIndexPath:indexPath];
        if (indexPath.section == 1 && indexPath.row == 0) {
            cell.titleLabel.text = @"每日美白时长";
            
            NSInteger times = [MeiBaiConfigFile getCureTimesEachDay];
            cell.contentLabel.text = [NSString stringWithFormat:@"%ld*8分钟",times];
            
            
        } else if(indexPath.section == 1&& indexPath.row ==1){
            cell.titleLabel.text = @"计划美白天数";
            
            NSInteger days = [MeiBaiConfigFile getNeedCureDays];
            cell.contentLabel.text = [NSString stringWithFormat:@"%ld天",days];
            
        } else{
            cell.titleLabel.text = @"每月保持时长";
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.contentLabel.text = @"4*8分钟";
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    } else{
        return 30.0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
        label.textColor = [UIColor blackColor];
        label.text = @"美白计划";
        
        [view addSubview:label];
        
        
        return view;
    } else if(section == 2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
        label.textColor = [UIColor blackColor];
        label.text = @"保持计划";
        [view addSubview:label];

        return view;
    } else{
        return nil;
    }
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
