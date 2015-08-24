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

#import "NetworkManager.h"
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>

#import "SocialDetailViewController.h"

@interface SocialViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataItems;

@property (nonatomic, assign) NSInteger currentPage;

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
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.currentPage = 0;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    [self.tableView.header beginRefreshing];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)loadData{
    
    [NetworkManager fetchPostsByStartIndex:0 pageSize:10 WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            
            self.currentPage = [responseObject[@"count"] integerValue];
            NSArray *data = responseObject[@"data"];
            NSLog(@"%@",data);
            
            self.dataItems = [data mutableCopy];
            
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络出错"];
        }
        
        [self.tableView.header endRefreshing];
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错了"];
        [self.tableView.header endRefreshing];

    }];
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
   
    NSArray *images = temp[@"resources"];
    
    if (images.count > 0) {
        
        SocialImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialImageCell" forIndexPath:indexPath];
        
        if (temp[@"avatar"]) {
            NSURL *headUrl =[[NSURL alloc] initWithString:temp[@"avatar"]];
            [cell.avatarImageView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"img_head"]];
        } else{
            cell.avatarImageView.image = [UIImage imageNamed:@"img_head"];
        }
        
        NSString *dateString = temp[@"createTime"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [formatter dateFromString:dateString];
        
        
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
        cell.commentsLabel.text  = [NSString stringWithFormat:@"%ld", [temp[@"callbacks"] integerValue]];
        cell.cotentLabel.text = temp[@"content"];
        cell.nameLabel.text = temp[@"nickName"];
        
        if (images.count == 1) {
            [cell.contentOneImageView sd_setImageWithURL:[NSURL URLWithString:images[0][@"thumb"]] placeholderImage:nil];
        } else if (images.count == 2){
            [cell.contentOneImageView sd_setImageWithURL:[NSURL URLWithString:images[0][@"thumb"]] placeholderImage:nil];
            [cell.contentTwoImageView sd_setImageWithURL:[NSURL URLWithString:images[1][@"thumb"]] placeholderImage:nil];

        } else{
            [cell.contentOneImageView sd_setImageWithURL:[NSURL URLWithString:images[0][@"thumb"]] placeholderImage:nil];
            [cell.contentTwoImageView sd_setImageWithURL:[NSURL URLWithString:images[1][@"thumb"]] placeholderImage:nil];
            [cell.contentThreeImageView sd_setImageWithURL:[NSURL URLWithString:images[2][@"thumb"]] placeholderImage:nil];
        }
        
        
        return cell;

    }else{
        SocialNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialNoImageCell" forIndexPath:indexPath];
        
        if (temp[@"avatar"]) {
            NSURL *headUrl =[[NSURL alloc] initWithString:temp[@"avatar"]];
            [cell.avatarImageView sd_setImageWithURL:headUrl placeholderImage:[UIImage imageNamed:@"img_head"]];
        } else{
            cell.avatarImageView.image = [UIImage imageNamed:@"img_head"];
        }

        
        NSString *dateString = temp[@"createTime"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [formatter dateFromString:dateString];
        
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
        cell.commentsLabel.text  = [NSString stringWithFormat:@"%ld", [temp[@"callbacks"] integerValue]];

        cell.contentLabel.text = temp[@"content"];
        cell.nameLabel.text = temp[@"nickName"];

        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIImageView *hotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"social_hot"]];
    hotImageView.frame = CGRectMake(12, 10, 16, 20);
    [view addSubview:hotImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 40)];
    label.text = @"大家都在聊";
    label.textColor = [UIColor grayColor];
    
    [view addSubview:label];
    
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SocialDetailViewController *detail = [[SocialDetailViewController alloc] initWithNibName:@"SocialDetailViewController" bundle:nil];
    
    detail.hidesBottomBarWhenPushed = YES;
    
    detail.topicDetail = self.dataItems[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

#pragma mark - post topic

-(void)publishTopic:(id)sender{
    PostTopicViewController *postVC = [[PostTopicViewController alloc] initWithNibName:@"PostTopicViewController" bundle:nil];
    postVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:postVC animated:YES];
}



@end
