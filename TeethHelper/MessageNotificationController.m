//
//  MessageNotificationController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MessageNotificationController.h"
#import "MessageOneCell.h"
#import "MessageTwoCell.h"
#import "Utils.h"
#import "MessageConfigureFile.h"

#import "MessageTimeChooseController.h"

@interface MessageNotificationController ()<UITableViewDelegate, UITableViewDataSource,TimeSelectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"消息推送" onViewController:self];
    self.tableView.tableFooterView =[UIView new];
    
    
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else{
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        MessageOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageOneCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"问卷提醒";
        [cell.switcher addTarget:self action:@selector(changeQustionNotification:) forControlEvents:UIControlEventValueChanged];

        if ([MessageConfigureFile isQuestionaireOpen]) {
            cell.switcher.on = YES;
        } else{
            cell.switcher.on = NO;
        }
        
        
        return cell;
    } else if(indexPath.row == 0 && indexPath.section == 1){
        MessageOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageOneCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"每日美白提醒";
        [cell.switcher addTarget:self action:@selector(changeAlertNotification:) forControlEvents:UIControlEventValueChanged];

        if ([MessageConfigureFile isOpenLocalNotification]) {
            cell.switcher.on = YES;
        } else{
            cell.switcher.on = NO;
        }
        

        return cell;
    } else{
        MessageTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTwoCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"美白时间";
        
        NSString *hour = [MessageConfigureFile hourForAlertNotification];
        NSString *minute = [MessageConfigureFile minuteForAlertNotification];
        cell.timeNoticeLabel.text = [NSString stringWithFormat:@"%@:%.2ld",hour,(long)[minute integerValue]];
        if ([MessageConfigureFile isOpenLocalNotification]) {
            cell.timeNoticeLabel.textColor = [UIColor blackColor];
        } else{
            cell.timeNoticeLabel.textColor = [UIColor lightGrayColor];

        }


        return cell;
    }
}

-(void)changeAlertNotification:(UISwitch *)switcher{
    if (switcher.isOn) {
        // 开启美白提醒
        [MessageConfigureFile setOpenLocalNotification:YES];
        NSString *hour = [MessageConfigureFile hourForAlertNotification];
        NSString *miniute =[MessageConfigureFile minuteForAlertNotification];
        [MessageConfigureFile setAlertNotificationTime:hour andMinute:miniute];
        
    } else {
        //关闭美白提醒
        [MessageConfigureFile setOpenLocalNotification:NO];
        [MessageConfigureFile cancelAlertNotification];

    }
    [self.tableView reloadData];
}

-(void)changeQustionNotification:(UISwitch *)switcher{
    if (switcher.isOn) {
        // 开启问卷提醒
        [MessageConfigureFile setQuestionaireOpenLocalNotification:YES];
    } else {
        //关闭问卷提醒
        [MessageConfigureFile setQuestionaireOpenLocalNotification:NO];

    }
    [self.tableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *temp = [[UIView alloc] initWithFrame:CGRectZero];
    temp.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    messageLabel.font = [UIFont systemFontOfSize:12.0];
    messageLabel.textColor = [UIColor whiteColor];
    if (section == 0) {
        messageLabel.text = @"美白后问卷未完成，你会收到推送";
    } else{
        messageLabel.text = @"每天定时推送美白提醒";
    }
    [temp addSubview:messageLabel];
    
    return temp;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 && [MessageConfigureFile isOpenLocalNotification]) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
        MessageTimeChooseController *timerVC = [sb instantiateViewControllerWithIdentifier:@"MessageTimeChooseController"];
        timerVC.delegate = self;
        [self presentViewController:timerVC animated:YES completion:nil];
    }
}

//选择推送时间以后，设置
-(void)didSelectTime:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *hour = [formatter stringFromDate:date];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"mm"];
    NSString *minute = [formatter1 stringFromDate:date];
    
    [MessageConfigureFile setAlertNotificationTime:hour andMinute:minute];
    [MessageConfigureFile setNotificationAtHour:hour minute:minute];
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
