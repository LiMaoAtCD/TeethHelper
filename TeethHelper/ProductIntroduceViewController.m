//
//  ProductIntroduceViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ProductIntroduceViewController.h"
#import "Utils.h"

#import "ProductDetailViewController.h"
#import "ProductCompositionViewController.h"
#import "NewGuideViewController.h"
#import "NoticeViewController.h"

#import "NetworkManager.h"
#import "ProductConfigFile.h"
#import <SVProgressHUD.h>


@interface ProductIntroduceViewController ()

@end

@implementation ProductIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"产品介绍" onViewController:self];
    self.navigationController.navigationBar.translucent = NO;
//    [self fetchProductInfo];
    
}

-(void)fetchProductInfo{
    
//    [SVProgressHUD showWithStatus:@"正在获取产品信息"];
    [NetworkManager fetchProductInfoWithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"] integerValue] == 2000) {
            NSArray *data = responseObject[@"data"];
            
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *temp = obj;
                
                if ([temp[@"type"] integerValue] == 1) {
                    
                    [ProductConfigFile setProductIntroduceSource:temp[@"source"]];
                    [ProductConfigFile setProductIntroduceSourceThumb:temp[@"thumb"]];
                } else if ([temp[@"type"] integerValue] == 2) {
                    [ProductConfigFile setProductGuideSource:temp[@"source"]];
                    [ProductConfigFile setProductGuideSourceThumb:temp[@"thumb"]];

                } else{
                    [ProductConfigFile setMeiBaiJiaoourceThumb:temp[@"thumb"]];
                    [ProductConfigFile setMeiBaiJiaoource:temp[@"source"]];

                }
            }];
            
            
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        } else{
        }
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}


-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;

    [super viewWillAppear:animated];
}

- (IBAction)clickForDetail:(id)sender {
    
    UIButton *button  = sender;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    switch (button.tag) {
        case 0:
        {
        //产品介绍
            
            ProductDetailViewController *detailVC  =[sb instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
            [self.navigationController showViewController:detailVC sender:self];
        }
            break;
        case 1:
        {
        //产品组成
            ProductCompositionViewController *compositionVC  =[sb instantiateViewControllerWithIdentifier:@"ProductCompositionViewController"];
            [self.navigationController showViewController:compositionVC sender:self];
        }
            break;
        case 2:
        {
        //新手指南
            NewGuideViewController *newVC  =[sb instantiateViewControllerWithIdentifier:@"NewGuideViewController"];
            [self.navigationController showViewController:newVC sender:self];
        }
            break;
        case 3:
        {
        //注意事项
            NoticeViewController *noticeVC  =[sb instantiateViewControllerWithIdentifier:@"NoticeViewController"];
            [self.navigationController showViewController:noticeVC sender:self];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
