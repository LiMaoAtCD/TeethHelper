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
#import "SocialDetailScrollToTopController.h"

#import "AccountManager.h"

@interface SocialDetailViewController ()<UITableViewDelegate, UITableViewDataSource,SocialLikeAndCommentDelegate,CommentDelegate,ScrollToTopDelegate>

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

@property (nonatomic, strong) SocialDetailScrollToTopController *scrollToTopVC;

@end

@implementation SocialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;

    //title
    [Utils ConfigNavigationBarWithTitle:@"主题详情" onViewController:self];
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
//        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 2000) {
            //
            [SVProgressHUD dismiss];
            
            self.gender = responseObject[@"data"][@"sex"];
            self.comments =[responseObject[@"data"][@"comments"] mutableCopy];
            self.numberOfLikes = [responseObject[@"data"][@"loves"] integerValue];
            
            BOOL isCancelable = responseObject[@"data"][@"canDelete"];
            
            
            if (isCancelable) {
                
                UIImage *imageOfDeletion = [UIImage imageNamed:@"btn_delete_normal"];
                UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
                [delete setImage:imageOfDeletion forState:UIControlStateNormal];
                [delete setImage:[UIImage imageNamed:@"btn_delete_pressed"] forState:UIControlStateHighlighted];
                [delete addTarget:self action:@selector(deleteThisTopic:) forControlEvents:UIControlEventTouchUpInside];
                
                UIImage *imageOfShare = [UIImage imageNamed:@"social_share_pressed"];
                UIButton *publish = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
                [publish setImage:imageOfShare forState:UIControlStateNormal];
                [publish setImage:[UIImage imageNamed:@"social_share_normal"] forState:UIControlStateHighlighted];
                [publish addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                self.navigationItem.rightBarButtonItems  = @[[[UIBarButtonItem alloc] initWithCustomView:publish],[[UIBarButtonItem alloc] initWithCustomView:delete]];
                
            } else{
                //分享按钮
                UIImage *image = [UIImage imageNamed:@"social_share_pressed"];
                UIButton *publish = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,18)];
                [publish setImage:image forState:UIControlStateNormal];
                [publish setImage:[UIImage imageNamed:@"social_share_normal"] forState:UIControlStateHighlighted];
                [publish addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publish];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];

            });
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
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

-(void)deleteThisTopic:(id)sender {
    
    [NetworkManager deleteTopicByID:self.topicDetail[@"id"] WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 2000) {
            
            if ([self.delegate respondsToSelector:@selector(refreshTableView)]) {
                [self.delegate refreshTableView];
            }
            
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([responseObject[@"status"] integerValue] == 1012){
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
        } else{
            [SVProgressHUD showErrorWithStatus:@"回复失败"];
        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableview delegate& datesource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return 0.01;
    } else{
        return 10.0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else{
        return self.comments.count ;

    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        
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
            
            [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:self.images[0][@"source"]] placeholderImage:nil];

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
            
            [cell.contentOneImageView sd_setImageWithURL:[NSURL URLWithString:self.images[0][@"source"]] placeholderImage:nil];
            [cell.contentTwoImageView sd_setImageWithURL:[NSURL URLWithString:self.images[1][@"source"]] placeholderImage:nil];

            
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
            [cell.contentOneimageView sd_setImageWithURL:[NSURL URLWithString:self.images[0][@"source"]] placeholderImage:nil];
            [cell.contentTwoImageView sd_setImageWithURL:[NSURL URLWithString:self.images[1][@"source"]] placeholderImage:nil];
            [cell.contentThreeImageView sd_setImageWithURL:[NSURL URLWithString:self.images[2][@"source"]] placeholderImage:nil];

            
            
            return cell;
        }

    } else{
        
        DetailReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailReplyCell" forIndexPath:indexPath];
        
        //TODO: 昵称
        NSString *nickName = self.comments[indexPath.row][@"nickName"];
        
        cell.nameLabel.text = nickName;
//        cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.comments] placeholderImage:<#(UIImage *)#>
        if ([self.comments[indexPath.row][@"avatar"] isEqualToString:@""]) {
            cell.avatarImageView.image = [UIImage imageNamed:@"img_head"];
        } else{
            [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.comments[indexPath.row][@"avatar"]] placeholderImage:[UIImage imageNamed:@"img_head"]];
        }
        
        
        NSString *dateString = self.comments[indexPath.row][@"createTime"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [formatter dateFromString:dateString];
        
        [formatter setDateFormat:@"MM"];
        
        NSString *month =[formatter stringFromDate:date];
        
        [formatter setDateFormat:@"dd"];
        
        NSString *day =[formatter stringFromDate:date];
        
        [formatter setDateFormat:@"yyyy"];
        
        NSString *year =[formatter stringFromDate:date];
        
        NSString *nowYear = [formatter stringFromDate:[NSDate date]];
        
        if (![nowYear isEqualToString:year]) {
            cell.commentDateLabel.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        } else{
            cell.commentDateLabel.text = [NSString stringWithFormat:@"%@-%@",month,day];
        }

        cell.commentLabel.text = self.comments[indexPath.row][@"reply"];
        
        if ([self.comments[indexPath.row][@"sex"] isEqualToString:@"男"]) {
            cell.genderImageView.image = [UIImage imageNamed:@"social_male"];
        } else if ([self.comments[indexPath.row][@"sex"]isEqualToString:@"女"]){
            cell.genderImageView.image = [UIImage imageNamed:@"social_female"];
        }
        
        cell.floorLabel.text = [NSString stringWithFormat:@"%ld楼",indexPath.row + 2];
        [cell setNeedsUpdateConstraints];
        return cell;
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"replySegue"]) {
        self.replyVC =  segue.destinationViewController;
        self.replyVC.delegate = self;
        
    }
    
    if ([segue.identifier isEqualToString:@"TopSegue"]) {
        //滑动
        self.scrollToTopVC = segue.destinationViewController;
        self.scrollToTopVC.delegate = self;
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
            }else if ([responseObject[@"status"] integerValue] == 1012){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
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
                
                
                self.replyVC.likeLabel.text = @"赞过了";
                self.replyVC.likeImageView.image = [UIImage imageNamed:@"social_like_click"];
                

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
    commentVC.delegate = self;
    [self presentViewController:commentVC animated:YES completion:nil];
}

-(void)postComment:(NSString *)comment{
    
    NSString *temp = [comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if ([temp length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"评论不能为空"];
    } else{
        [NetworkManager replyToID:self.topicDetail[@"id"] ByCommentContent:comment WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[@"status"] integerValue] == 2000) {
                [SVProgressHUD showSuccessWithStatus:@"回复成功"];
                
                [self addCommentsToLocalDataSources:comment];
                self.numberOfComments++;
                
                
                [self.tableView reloadData];
                
            }else if ([responseObject[@"status"] integerValue] == 1012){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
            } else{
                [SVProgressHUD showErrorWithStatus:@"回复失败"];
                
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络出错"];
        }];

    }
    
}

-(void)addCommentsToLocalDataSources:(NSString*)comment{
    
    
//    {
//        avatar = "http://120.25.232.115/images/teeth/avatar/ace5e7b2e96a4fb99e25a5f93cd2cd09.jpg";
//        createTime = "2015-08-30 13:59:18";
//        reply = "\U6211";
//        sex = "\U7537";
//    }
    
    NSString *avatar = [AccountManager getAvatarUrlString];
    
    if (avatar == nil) {
        avatar = @"";
    }

//    NSString *createTime = [NSDate date];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *createTime = [formatter stringFromDate:[NSDate date]];
    
    NSString *reply = comment;
    NSString *sex = [AccountManager getGender];
    
    if (sex == nil || [sex isKindOfClass:[NSNull class]]) {
        sex = @"男";
    }
    
    NSDictionary *mycommentsItems = @{@"avatar":avatar,@"createTime":createTime, @"reply":reply,@"sex":sex,@"nickName":[AccountManager getName]};

    [self.comments addObject:mycommentsItems];
    
    
    
    
    
//    [self.tableView beginUpdates];
//    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.comments.count - 1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//
//    [self.tableView endUpdates];
    
    
    
    
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.comments.count - 1 inSection:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];

    
//    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.comments[indexPath.row][@"avatar"]] placeholderImage:[UIImage imageNamed:@"img_head"]];
//    
//    NSString *dateString = self.comments[indexPath.row][@"createTime"];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *date = [formatter dateFromString:dateString];
//    
//    [formatter setDateFormat:@"MM"];
//    
//    NSString *month =[formatter stringFromDate:date];
//    
//    [formatter setDateFormat:@"dd"];
//    
//    NSString *day =[formatter stringFromDate:date];
//    
//    [formatter setDateFormat:@"yyyy"];
//    
//    NSString *year =[formatter stringFromDate:date];
//    
//    NSString *nowYear = [formatter stringFromDate:[NSDate date]];
//    
//    if (![nowYear isEqualToString:year]) {
//        cell.commentDateLabel.text = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
//    } else{
//        cell.commentDateLabel.text = [NSString stringWithFormat:@"%@-%@",month,day];
//    }
//    
//    cell.commentLabel.text = self.comments[indexPath.row][@"reply"];
//    
//    if ([self.comments[indexPath.row][@"sex"] isEqualToString:@"男"]) {
//        cell.genderImageView.image = [UIImage imageNamed:@"social_male"];
//    } else if ([self.comments[indexPath.row][@"sex"]isEqualToString:@"女"]){
//        cell.genderImageView.image = [UIImage imageNamed:@"social_female"];
//    }
//    
//    cell.floorLabel.text = [NSString stringWithFormat:@"%ld楼",indexPath.row + 2];

    
    
    
    
    
}

-(void)needScrollToTop{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}





@end
