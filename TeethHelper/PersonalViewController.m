//
//  PersonalViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "PersonalViewController.h"
#import "Utils.h"
#import "PersonalTableViewCell.h"

#import "MessageNotificationController.h"
#import "TeethStateViewController.h"
#import "MeiBaiProjectViewController.h"
#import "CeBaiHistoryViewController.h"
#import "UseHistoryViewController.h"
#import "PersonalInfoViewController.h"

#import "AccountManager.h"

#import "LoginNavigationController.h"


@interface PersonalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *items;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"我" onViewController:self];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = nil;
    
    self.items = @[@"个人信息",@"使用记录",@"测白记录",@"美白计划",@"牙齿状况",@"消息推送"];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [logoutButton setBackgroundColor:[UIColor colorWithRed:99./255. green:181./255 blue:185./255 alpha:1.0]];
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    
    logoutButton.frame = CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 40);
    [logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutButton];
    
    self.tableView.tableFooterView = footerView;
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
    return  self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.items[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
            PersonalInfoViewController *infoVC = [sb instantiateViewControllerWithIdentifier:@"PersonalInfoViewController"];
            infoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:infoVC animated:YES];
        }
            break;
        case 1:
        {
            UseHistoryViewController *useVC = [sb instantiateViewControllerWithIdentifier:@"UseHistoryViewController"];
            useVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:useVC animated:YES];
        }
            break;
        case 2:
        {
            CeBaiHistoryViewController *cebaiVC =[sb instantiateViewControllerWithIdentifier:@"CeBaiHistoryViewController"];
            cebaiVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cebaiVC animated:YES];

        }
            break;
        case 3:
        {
            MeiBaiProjectViewController *cebaiVC =[sb instantiateViewControllerWithIdentifier:@"MeiBaiProjectViewController"];
            cebaiVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cebaiVC animated:YES];
        }
            break;
        case 4:
        {
            TeethStateViewController *cebaiVC =[sb instantiateViewControllerWithIdentifier:@"TeethStateViewController"];
            cebaiVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cebaiVC animated:YES];
        }
            break;
        case 5:
        {
            MessageNotificationController *cebaiVC =[sb instantiateViewControllerWithIdentifier:@"MessageNotificationController"];
            cebaiVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cebaiVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)logout:(UIButton *)button{
    [AccountManager setLogin:NO];
    [AccountManager setAvatarUrlString:nil];
    [AccountManager setName:nil];
    [AccountManager setgender:nil];
    [AccountManager setAddress:nil];
    [AccountManager setTokenID:nil];
    [AccountManager setBirthDay:nil];
    [AccountManager setPassword:nil];
    [AccountManager setCellphoneNumber:nil];
    

    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginNavigationController *loginVC = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    
    [self showDetailViewController:loginVC sender:self];
    [self.tabBarController setSelectedIndex:0];

    
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
