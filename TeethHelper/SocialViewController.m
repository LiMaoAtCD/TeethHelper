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
#import "SocialRefreshDelegate.h"
@interface SocialViewController ()<UITableViewDelegate, UITableViewDataSource,SocialRefreshDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataItems;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL isNeedRefresh;



@end

static const NSInteger PageSize = 20;

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
    
    
    
    
    self.dataItems = [NSMutableArray array];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self.tableView.header beginRefreshing];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    if (self.isNeedRefresh) {
        [self.tableView.header beginRefreshing];
        self.isNeedRefresh = NO;
    }

}
-(void)loadData{
//    [NetworkManager fetchPostsByStartIndex:0 pageSize:PageSize WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self.tableView.header endRefreshing];
//
//        if ([responseObject[@"status"] integerValue] == 2000) {
//            NSArray *data = responseObject[@"data"];
//            //判断是不是第一次
//            
//            if (self.dataItems.count == 0) {
//                //第一次
//                self.dataItems = [data mutableCopy];
//                [self.tableView reloadData];
//                self.currentIndex = self.dataItems.count;
//                
//                if (self.currentIndex < PageSize) {
//                    [self.tableView.footer noticeNoMoreData];
//                }
//            } else{
//                if (data.count > 0) {
//                    if ([self.dataItems[0][@"createTime"] isEqualToString:data[0][@"createTime"]]) {
//                        //如果没有新数据
//                    } else{
//                        self.dataItems = [data mutableCopy];
//                        self.currentIndex = self.dataItems.count;
//                        [self.tableView reloadData];
//                        [self.tableView.footer resetNoMoreData];
//                    }
//                }
//            }
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"获取失败"];
//        }
//    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"网络出错了"];
//        [self.tableView.header endRefreshing];
//    }];
    
    [NetworkManager fetchPostsByStartIndex:0 pageSize:PageSize WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            NSArray *data = responseObject[@"data"];
            //判断是不是第一次
            
            self.dataItems = [data mutableCopy];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];

//            });
            
            self.currentIndex = self.dataItems.count;
            
//            if (self.currentIndex < PageSize) {
                [self.tableView.footer resetNoMoreData];
//            }
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错了"];
        [self.tableView.header endRefreshing];
    }];
}

-(void)loadMoreData{
    
    [NetworkManager fetchPostsByStartIndex:self.currentIndex pageSize:PageSize WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.footer endRefreshing];

        if ([responseObject[@"status"] integerValue] == 2000) {
            
            NSArray *data = responseObject[@"data"];
            [self.dataItems addObjectsFromArray:data];

//            self.automaticallyAdjustsScrollViewInsets = NO;
            [self.tableView reloadData];
            self.currentIndex += data.count;
            
            if (data.count < PageSize) {
                
                [self.tableView.footer noticeNoMoreData];
            } else{
                [self.tableView.footer resetNoMoreData];
            }

            
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"获取失败"];
        }
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错了"];
        [self.tableView.footer endRefreshing];
        
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
        
        cell.loveLabel.text = [NSString stringWithFormat:@"%ld",[temp[@"loves"] integerValue]];
        
        if (images.count == 1) {
            [cell.contentOneImageView sd_setImageWithURL:[NSURL URLWithString:images[0][@"thumb"]] placeholderImage:nil];
            cell.contentTwoImageView.image = nil;
            cell.contentThreeImageView.image = nil;
        } else if (images.count == 2){
            [cell.contentOneImageView sd_setImageWithURL:[NSURL URLWithString:images[0][@"thumb"]] placeholderImage:nil];
            [cell.contentTwoImageView sd_setImageWithURL:[NSURL URLWithString:images[1][@"thumb"]] placeholderImage:nil];
            cell.contentThreeImageView.image = nil;

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
        
        cell.loveLabel.text = [NSString stringWithFormat:@"%ld",[temp[@"loves"] integerValue]];


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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SocialDetailViewController *detail = [sb instantiateViewControllerWithIdentifier:@"SocialDetailViewController"];
    
    detail.hidesBottomBarWhenPushed = YES;
    
    detail.topicDetail = self.dataItems[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

#pragma mark - post topic

-(void)publishTopic:(id)sender{
    PostTopicViewController *postVC = [[PostTopicViewController alloc] initWithNibName:@"PostTopicViewController" bundle:nil];
    postVC.hidesBottomBarWhenPushed = YES;
    postVC.delegate = self;
    [self.navigationController pushViewController:postVC animated:YES];
}

-(void)refreshTableView{
    self.isNeedRefresh = YES;
}



@end
