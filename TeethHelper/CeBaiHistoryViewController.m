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
#import "NetworkManager.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "CameraViewController.h"
#import "ImageEditViewController.h"
#import "AccountManager.h"
#import "CeBaiAlertController.h"

@interface CeBaiHistoryViewController ()<UITableViewDelegate, UITableViewDataSource,PhotoDelegate,AlertSelectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataItems;

@property (nonatomic, assign) NSInteger currentIndex;

@end

static const NSInteger pageSize = 20;

@implementation CeBaiHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
    
    [Utils ConfigNavigationBarWithTitle:@"测白记录" onViewController:self];
    
    self.dataItems = [NSMutableArray array];
    self.currentIndex = 0;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    
    [self.tableView.header beginRefreshing];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self fetchMoreData];

    }];
    
    //重置按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"重置" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

}
-(void)reset:(id)sender{
    
    CeBaiAlertController * alert = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil] instantiateViewControllerWithIdentifier:@"CeBaiAlertController"];
    alert.delegate = self;
    [self presentViewController:alert animated:NO completion:nil];
    
    
  
}

-(void)didSelectedCancel:(BOOL)cancel{
    if (cancel) {
        
    } else{
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CameraViewController *cameraVC = [sb instantiateViewControllerWithIdentifier:@"CameraViewController"];
        cameraVC.delegate = self;
        cameraVC.hidesBottomBarWhenPushed = YES;
        [AccountManager NeedResetFirstCeBai:YES];
        
        [self.navigationController pushViewController:cameraVC animated:YES];
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


-(void)fetchData{
    [NetworkManager fetchCeBaiHistoryStartIndex:self.currentIndex andPageSize:pageSize WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.header endRefreshing];
        
        NSLog(@"response %@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            NSArray *data = responseObject[@"data"];
            //判断是不是第一次
            
            if (self.dataItems.count == 0) {
                //第一次
                self.dataItems = [data mutableCopy];
                [self.tableView reloadData];
                self.currentIndex = self.dataItems.count;
                
                if (self.currentIndex < pageSize) {
                    [self.tableView.footer noticeNoMoreData];
                }
            } else{
                if (data.count > 0) {
                    if ([self.dataItems[0][@"createTime"] isEqualToString:data[0][@"createTime"]]) {
                        //如果没有新数据
                    } else{
                        self.dataItems = [data mutableCopy];
                        self.currentIndex = self.dataItems.count;
                        [self.tableView reloadData];
                        [self.tableView.footer resetNoMoreData];
                    }
                }
            }
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"获取失败"];

        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络出错了"];

    }];

}

-(void)fetchMoreData{
    
    [NetworkManager fetchCeBaiHistoryStartIndex:self.currentIndex andPageSize:pageSize WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView.footer endRefreshing];
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            
            NSArray *data = responseObject[@"data"];
            [self.dataItems addObjectsFromArray:data];
            
            [self.tableView reloadData];
            self.currentIndex += data.count;
            
            if (data.count < pageSize) {
                
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CeBaiHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CeBaiHistoryCell" forIndexPath:indexPath];
    
    if (indexPath.row != 0) {
        cell.topLine.hidden = YES;
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *createTime = [formatter dateFromString:self.dataItems[indexPath.row][@"createTime"]];
    
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *dateString = [formatter stringFromDate:createTime];
    
    [formatter setDateFormat:@"hh:mm"];
    
    NSString *timeString = [formatter stringFromDate:createTime];
    
    NSString *levelString = self.dataItems[indexPath.row][@"color"];
    
    cell.dateLabel.text = dateString;
    cell.timeLabel.text = timeString;
    cell.levelLabel.text = levelString;
    
    
    
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

-(void)getPhotoFromCamera:(UIImage *)image{
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImageEditViewController *editorVC = [sb instantiateViewControllerWithIdentifier:@"ImageEditViewController"];
    
    editorVC.sourceImage  = image;
    editorVC.hidesBottomBarWhenPushed = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:editorVC animated:YES];
        
    });
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.dataItems removeObjectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
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
