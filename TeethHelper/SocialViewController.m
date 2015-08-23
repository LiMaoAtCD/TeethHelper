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
#import "PostTopicViewController.h"

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
    UIImage *image = [UIImage imageNamed:@"social_post_normal"];
    UIButton *publish = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
    
    [publish setImage:image forState:UIControlStateNormal];
    [publish setImage:[UIImage imageNamed:@"social_post_pressed"] forState:UIControlStateHighlighted];

    [publish addTarget:self action:@selector(publishTopic:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publish];
    
    self.dataItems = [NSMutableArray array];

    self.dataItems =[@[
                       @{
                           @"avatar":@"xxx",
                           @"date":[NSDate dateWithTimeInterval:-70 sinceDate:[NSDate date]],
                           @"containImage":@1
                         },
                       @{
                           @"avatar":@"xxx",
                           @"date":[NSDate dateWithTimeInterval:-1 sinceDate:[NSDate date]],
                           @"containImage":@0
                         },
                       @{
                             @"avatar":@"xxx",
                             @"date":[NSDate dateWithTimeInterval:-5000 sinceDate:[NSDate date]],
                             @"containImage":@0
                         },
                       @{
                           @"avatar":@"xxx",
                           @"date":[NSDate dateWithTimeInterval:-3600*27 sinceDate:[NSDate date]],
                           @"containImage":@0
                         }
                       
                       ] mutableCopy];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
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
    return self.dataItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *temp = self.dataItems[indexPath.row];
    if ([temp[@"containImage"] integerValue] == 1) {
        SocialImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialImageCell" forIndexPath:indexPath];
        
        NSDate *date = temp[@"date"];
        
        if (date.secondsAgo <= 60) {
            cell.timeStampLabel.text = @"刚刚";
        } else if (date.minutesAgo <= 60 ){
            cell.timeStampLabel.text =[NSString stringWithFormat:@"%ld分钟前",(long)date.minutesAgo];
        } else if (date.hoursAgo <= 24){
            cell.timeStampLabel.text =[NSString stringWithFormat:@"%ld小时前",(long)date.hoursAgo];
        } else{
            
            NSDateFormatter *MonthFormatter = [[NSDateFormatter alloc] init];
            [MonthFormatter setDateFormat:@"MM"];
            NSString *month = [MonthFormatter stringFromDate:date];
            
            NSDateFormatter *DayFormatter = [[NSDateFormatter alloc] init];
            [DayFormatter setDateFormat:@"dd"];
            NSString *day = [DayFormatter stringFromDate:date];
            
            NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
            [hourFormatter setDateFormat:@"HH"];
            NSString *hour = [hourFormatter stringFromDate:date];
            NSDateFormatter *MinuteFormatter = [[NSDateFormatter alloc] init];
            [MinuteFormatter setDateFormat:@"mm"];
            NSString *minute = [MinuteFormatter stringFromDate:date];
            
            
            NSString *timestamp = [NSString stringWithFormat:@"%@月%@日 %@:%@",month,day,hour,minute];
            
            cell.timeStampLabel.text = timestamp;
        }
        
        cell.cotentLabel.text = @"1刚打开结婚发疯节哈看见奋斗哈健康地方哈家开发和大家康复哈觉得符合啊了就罚款";
        
        return cell;
    } else{
        SocialNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialNoImageCell" forIndexPath:indexPath];
        
        NSDate *date = temp[@"date"];
        
        if (date.secondsAgo <= 60) {
            cell.timeStampLabel.text = @"刚刚";
        } else if (date.minutesAgo <= 60 ){
            cell.timeStampLabel.text =[NSString stringWithFormat:@"%ld分钟前",(long)date.minutesAgo];
        } else if (date.hoursAgo <= 24){
            cell.timeStampLabel.text =[NSString stringWithFormat:@"%ld小时前",(long)date.hoursAgo];
        } else{
            
            NSDateFormatter *MonthFormatter = [[NSDateFormatter alloc] init];
            [MonthFormatter setDateFormat:@"MM"];
            NSString *month = [MonthFormatter stringFromDate:date];
            
            NSDateFormatter *DayFormatter = [[NSDateFormatter alloc] init];
            [DayFormatter setDateFormat:@"dd"];
            NSString *day = [DayFormatter stringFromDate:date];
            
            NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
            [hourFormatter setDateFormat:@"HH"];
            NSString *hour = [hourFormatter stringFromDate:date];
            NSDateFormatter *MinuteFormatter = [[NSDateFormatter alloc] init];
            [MinuteFormatter setDateFormat:@"mm"];
            NSString *minute = [MinuteFormatter stringFromDate:date];
            
            
            NSString *timestamp = [NSString stringWithFormat:@"%@月%@日 %@:%@",month,day,hour,minute];
            
            cell.timeStampLabel.text = timestamp;
        }

        cell.contentLabel.text = @"2刚打开结婚发疯节哈看见奋斗哈健康地方哈家开发和大家康复哈觉得符合啊了就罚款";
        return cell;
    }
}

#pragma mark - post topic

-(void)publishTopic:(id)sender{
    PostTopicViewController *postVC = [[PostTopicViewController alloc] initWithNibName:@"PostTopicViewController" bundle:nil];
    postVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:postVC animated:YES];
}



@end
