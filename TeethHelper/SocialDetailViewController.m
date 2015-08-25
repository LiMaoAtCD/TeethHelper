//
//  SocialDetailViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/24.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialDetailViewController.h"
#import "Utils.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>
#import "WechatShareViewController.h"

#import "SocialDetailNoImageCell.h"
#import "SocialDetailOneCell.h"
#import "SocialDetailTwoCell.h"
#import "SocialDetailThreeCell.h"
#import "DetailReplyCell.h"

#import <UIImageView+WebCache.h>

#import "SocialDetailReplyViewController.h"
#import "SocialCommentViewController.h"

@interface SocialDetailViewController ()<UITableViewDelegate, UITableViewDataSource,SocialLikeAndCommentDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


//楼主头像
@property (nonatomic, copy) NSString *avatarURL;
//楼主昵称
@property (nonatomic, copy) NSString *nickName;
//评论数
@property (nonatomic, assign) NSInteger numberOfComments;
//点赞数
@property (nonatomic, assign) NSInteger numberOfLikes;
//性别
@property (nonatomic, copy) NSString *gender;
//文本内容
@property (nonatomic, copy) NSString *content;
//图片链接
@property (nonatomic, strong) NSMutableArray *images;

//评论
@property (nonatomic, strong) NSMutableArray *comments;


//时间
@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) SocialDetailReplyViewController *replyVC;


@end

@implementation SocialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;

    //title
    [Utils ConfigNavigationBarWithTitle:@"主题详情" onViewController:self];
     //分享按钮
    UIImage *image = [UIImage imageNamed:@"social_share_pressed"];
    UIButton *publish = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
    [publish setImage:image forState:UIControlStateNormal];
    [publish setImage:[UIImage imageNamed:@"social_share_normal"] forState:UIControlStateHighlighted];
    [publish addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publish];
    //头像
    if ([[self.topicDetail allKeys] containsObject:@"avatar"]) {
        self.avatarURL = self.topicDetail[@"avatar"];
    }
    //昵称
    if ([[self.topicDetail allKeys] containsObject:@"nickName"]) {
        self.nickName = self.topicDetail[@"nickName"];
    }
    //回复数
    if ([[self.topicDetail allKeys] containsObject:@"callbacks"]) {
        self.numberOfComments = [self.topicDetail[@"callbacks"] integerValue];
    }
    //点赞数
    if ([[self.topicDetail allKeys] containsObject:@"loves"]) {
        self.numberOfLikes = [self.topicDetail[@"loves"] integerValue];
    }
    //文本内容
    if ([[self.topicDetail allKeys] containsObject:@"content"]) {
        self.content = self.topicDetail[@"content"];
    }
    //图片数组
    self.images = self.topicDetail[@"resources"];
    
    //tableview 配置
    [self configTableView];
    
    //请求
    [SVProgressHUD showWithStatus:@"正在获取详情"];
    [NetworkManager fetchTopicDetailByTopicID:self.topicDetail[@"id"] WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            //
            [SVProgressHUD dismiss];
            
            self.gender = responseObject[@"data"][@"sex"];
            self.comments = responseObject[@"data"][@"comments"];
            self.numberOfLikes = [responseObject[@"data"][@"loves"] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];

            });
        } else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
    
 
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
}

-(void)configTableView{
    
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    if (self.images.count == 0) {
        [self.tableView registerNib:[UINib nibWithNibName:@"SocialDetailNoImageCell" bundle:nil] forCellReuseIdentifier:@"SocialDetailNoImageCell"];

    }else if(self.images.count == 1){
        [self.tableView registerNib:[UINib nibWithNibName:@"SocialDetailOneCell" bundle:nil] forCellReuseIdentifier:@"SocialDetailOneCell"];

    } else if (self.images.count == 2){
        [self.tableView registerNib:[UINib nibWithNibName:@"SocialDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"SocialDetailTwoCell"];

    } else{
        [self.tableView registerNib:[UINib nibWithNibName:@"SocialDetailThreeCell" bundle:nil] forCellReuseIdentifier:@"SocialDetailThreeCell"];

    }
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailReplyCell" bundle:nil] forCellReuseIdentifier:@"DetailReplyCell"];
    self.tableView.tableFooterView = [UIView new];
    

}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)share:(UIButton *)button{
    WechatShareViewController *wechat = [[WechatShareViewController alloc] initWithNibName:@"WechatShareViewController" bundle:nil];
    wechat.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:wechat animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        if (self.images.count == 0) {
            SocialDetailNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialDetailNoImageCell" forIndexPath:indexPath];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.avatarURL] placeholderImage:[UIImage imageNamed:@"img_head"]];
            cell.nameLabel.text = self.nickName;
            
            if ([self.gender isEqualToString:@"男"]) {
                cell.genderImageView.image = [UIImage imageNamed:@"social_male"];
            } else if ([self.gender isEqualToString:@"女"]){
                cell.genderImageView.image = [UIImage imageNamed:@"social_female"];
            }
            cell.contentLabel.text = self.content;
            
            cell.commentsLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfComments];
             cell.loveLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfLikes];
            
            return cell;

        } else if (self.images.count == 1){
            
            SocialDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialDetailOneCell" forIndexPath:indexPath];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.avatarURL] placeholderImage:[UIImage imageNamed:@"img_head"]];
            cell.nameLabel.text = self.nickName;
            cell.genderImageView.image = [UIImage imageNamed:@""];
            cell.contentLabel.text = self.content;
            cell.commentsLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfComments];
            cell.loveLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfLikes];
            if ([self.gender isEqualToString:@"男"]) {
                cell.genderImageView.image = [UIImage imageNamed:@"social_male"];
            } else if ([self.gender isEqualToString:@"女"]){
                cell.genderImageView.image = [UIImage imageNamed:@"social_female"];
            }

            return cell;
        }else if (self.images.count == 2){
            SocialDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialDetailTwoCell" forIndexPath:indexPath];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.avatarURL] placeholderImage:[UIImage imageNamed:@"img_head"]];
            cell.nameLabel.text = self.nickName;
            cell.contentLabel.text = self.content;
             cell.commentsLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfComments];
            cell.loveLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfLikes];
            if ([self.gender isEqualToString:@"男"]) {
                cell.genderImageView.image = [UIImage imageNamed:@"social_male"];
            } else if ([self.gender isEqualToString:@"女"]){
                cell.genderImageView.image = [UIImage imageNamed:@"social_female"];
            }
            return cell;
        } else{
            SocialDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialDetailThreeCell" forIndexPath:indexPath];
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.avatarURL] placeholderImage:[UIImage imageNamed:@"img_head"]];
            cell.nameLabel.text = self.nickName;
            cell.contentLabel.text = self.content;
            cell.commentsLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfComments];
            cell.loveLabel.text = [NSString stringWithFormat:@"%ld",self.numberOfLikes];
            if ([self.gender isEqualToString:@"男"]) {
                cell.genderImageView.image = [UIImage imageNamed:@"social_male"];
            } else if ([self.gender isEqualToString:@"女"]){
                cell.genderImageView.image = [UIImage imageNamed:@"social_female"];
            }
            
            
            
            return cell;
        }

    } else{
        
        DetailReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailReplyCell" forIndexPath:indexPath];
        
//        cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.comments] placeholderImage:<#(UIImage *)#>
        
        
        return cell;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"replySegue"]) {
        self.replyVC =  segue.destinationViewController;
        self.replyVC.delegate = self;
        
        // 查询当前帖子是否已赞
        
        [NetworkManager LikeTopicByID:self.topicDetail[@"id"] WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[@"status"] integerValue] == 2000) {
                if ([responseObject[@"data"] integerValue] == 0) {
                    self.replyVC.likeLabel.text = @"赞过了";
                    self.replyVC.likeImageView.image = [UIImage imageNamed:@"social_like_click"];
                }
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}


#pragma mark -点击点赞
-(void)didClickLike{
    
    [NetworkManager LikeTopicByID:self.topicDetail[@"id"] WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 2000) {
            if ([responseObject[@"data"] integerValue] == YES) {
                //点赞成功
                
                self.numberOfLikes++;
                self.replyVC.likeLabel.text = @"赞过了";
                self.replyVC.likeImageView.image = [UIImage imageNamed:@"social_like_click"];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            } else{
                //已经点赞了
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
                view.backgroundColor = [UIColor blackColor];
                
                UILabel *label =[[UILabel alloc] initWithFrame:view.bounds];
                label.text = @"已赞";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                
                [view addSubview:label];
                
                [self.view addSubview:view];
                view.center = CGPointMake(self.view.center.x, self.view.center.y - 100.0);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [view removeFromSuperview];
                });

            }
        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
}

#pragma mark -点击评论
-(void)didCommentPressed{
    
    SocialCommentViewController *commentVC = [[SocialCommentViewController alloc] initWithNibName:@"SocialCommentViewController" bundle:nil];
    
    commentVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:commentVC animated:YES completion:nil];
}



@end
