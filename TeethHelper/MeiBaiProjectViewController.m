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
#import "MeiBaiThreeCell.h"

#import "MeiBaiConfigFile.h"
#import "Utils.h"
#import "MeibaiItemChooseController.h"
@interface MeiBaiProjectViewController ()<UITableViewDelegate, UITableViewDataSource,ItemChooseDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *dayArr;
@property(nonatomic, strong) NSMutableArray *timesArr;


@end

@implementation MeiBaiProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"美白计划" onViewController:self];
    
    
    //美白计划选择数组
    self.dayArr =[NSMutableArray array];
    self.timesArr =[NSMutableArray array];
    for (int i =3; i < 16; i++) {
        
        NSString *dayString = [NSString stringWithFormat:@"%d 天",i];
        [self.dayArr addObject:dayString];
    }
    
    for (int i =3; i < 8; i++) {
        
        NSString *dayString = [NSString stringWithFormat:@"%d * 8 分钟",i];
        [self.timesArr addObject:dayString];
    }
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

        BOOL isKeepMeiBaiProject = [MeiBaiConfigFile isKeepProject];
        if (isKeepMeiBaiProject) {
            cell.swither.on = YES;
        } else{
            cell.swither.on = NO;
        }
        [cell.swither addTarget:self action:@selector(changeKeepProject:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
        
    } else{
        if (indexPath.section == 1 && indexPath.row == 0) {
            MeiBaiTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeiBaiTwoCell" forIndexPath:indexPath];
            cell.titleLabel.text = @"每日美白时长";
            
            NSInteger times = [MeiBaiConfigFile getCureTimesEachDay];
            cell.contentLabel.text = [NSString stringWithFormat:@"%ld*8 分钟",times];
            
            return cell;

        } else if(indexPath.section == 1&& indexPath.row ==1){
            MeiBaiTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeiBaiTwoCell" forIndexPath:indexPath];
            cell.titleLabel.text = @"计划美白天数";
            
            NSInteger days = [MeiBaiConfigFile getNeedCureDays];
            cell.contentLabel.text = [NSString stringWithFormat:@"%ld 天",days];
            return cell;

        } else{
            MeiBaiThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeiBaiThreeCell" forIndexPath:indexPath];
            cell.titleLabel.text = @"每月保持时长";
            cell.contentLabel.text = @"4*8 分钟";
            
            if ([MeiBaiConfigFile isKeepProject]) {
                cell.titleLabel.textColor = [Utils commonColor];
                cell.contentLabel.textColor = [UIColor blackColor];
            } else{
                cell.titleLabel.textColor = [UIColor grayColor];
                cell.contentLabel.textColor = [UIColor grayColor];

            }
            
            
            return cell;

        }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    MeibaiItemChooseController *itemVC = [sb instantiateViewControllerWithIdentifier:@"MeibaiItemChooseController"];
    itemVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    if (indexPath.section == 1 && indexPath.row == 0) {
        //次数 3-7
        itemVC.type = Times;
        itemVC.items = self.timesArr;
    } else if(indexPath.section == 1&& indexPath.row == 1){
        //天数3-15
        itemVC.type = Days;
        itemVC.items = self.dayArr;

    }
    itemVC.delegate = self;
    [self showDetailViewController:itemVC sender:self];
    

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
        if ([MeiBaiConfigFile isKeepProject]) {
            label.textColor = [UIColor blackColor];
        } else{
            label.textColor = [UIColor grayColor];

        }
        label.text = @"保持计划";
        [view addSubview:label];

        return view;
    } else{
        return nil;
    }
}

-(void)changeKeepProject:(UISwitch*)switcher{
    if (switcher.isOn) {
        [MeiBaiConfigFile setBeginKeepProject:YES];
    } else{
        [MeiBaiConfigFile setBeginKeepProject:NO];

    }
    [self.tableView reloadData];
}

-(void)didSelectedIndexAt:(NSInteger)index OnType:(ItemType)type{
    if (type == Times) {
        //选择了时长
        
        [MeiBaiConfigFile setCureTimesEachDay:(3+ index)];
        
    }else{
        [MeiBaiConfigFile setNeedCureDays:(3 + index)];
    }
    
    [self.tableView reloadData];
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
