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

@interface MessageNotificationController ()<UITableViewDelegate, UITableViewDataSource>

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
        
        if ([MessageConfigureFile isQuestionaireOpen]) {
            cell.switcher.on = YES;
        } else{
            cell.switcher.on = NO;
        }
        
        
        return cell;
    } else if(indexPath.row == 0 && indexPath.section == 1){
        MessageOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageOneCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"每日美白提醒";
        if ([MessageConfigureFile isOpenLocalNotification]) {
            cell.switcher.on = YES;
        } else{
            cell.switcher.on = NO;
        }
        

        return cell;
    } else{
        MessageTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTwoCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"美白时间";

        return cell;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
