//
//  TeethDetailTwoController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "TeethDetailTwoController.h"
#import "TeethChooseView.h"
#import <Masonry.h>
#import "Utils.h"
#import "TeethStateConfigureFile.h"
#import "MeiBaiConfigFile.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>

@interface TeethDetailTwoController ()

@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation TeethDetailTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"冷酸敏感" onViewController:self];
    
    NSArray *arr = @[@"是",@"否"];
    
    self.views = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)];
        
        TeethChooseView *view = [[TeethChooseView alloc] initWithTitle:arr[i]];
        view.tag = i;
        [view addGestureRecognizer:tap];
        
        
        
        [self.views addObject:view];
        [self.view addSubview:self.views[i]];
        [self.views[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(64 + 20 +  70 * i);
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.height.equalTo(@50);
            
        }];
        
    }
    [self.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TeethChooseView *view = obj;
        if (idx == _currentIndex) {
            [view didCHangeColorType:Selected];

        } else{
            [view didCHangeColorType:Normal];
            
        }
    }];
}

-(void)selectIndex:(id)sender{
    
    UITapGestureRecognizer *tap = sender;
    [self.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TeethChooseView *view = obj;
        if (idx == tap.view.tag) {
            
            [view didCHangeColorType:Selected];
            if (idx == 0) {
                
                [TeethStateConfigureFile setSensitive:YES];
            } else{
                [TeethStateConfigureFile setSensitive:NO];
            }
            
            
            
            
            //获取当前牙齿等级
            NSInteger answer1 = [TeethStateConfigureFile teethLevel];
            // 是否敏感
            NSInteger answer2 = idx;
            //是否意愿强烈
            NSInteger answer3 = 0;
            if ([TeethStateConfigureFile isWillStrong]) {
                answer3 = 0;
            } else{
                answer3 = 1;
            }
            NSLog(@"answer1:%ld \n answer2: %ld \n answer3: %ld",answer1,answer2,answer3);
            
            
            MEIBAI_PROJECT project =  [MeiBaiConfigFile getCurrentProject];
            if (answer1 == 0 && answer2 == 1 && answer3 == 0) {
                //提示修改至加强计划
                if (project != ENHANCE && project != KEEP) {
                    [self alertUserToModifyProject:ENHANCE withAlertHandler:^{
                        //
                        
                        [SVProgressHUD showWithStatus:@"正在调整计划"];
                        
                        [NetworkManager ModifyProject:@"B" WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSLog(@"response %@",responseObject);
                            if ([responseObject[@"status"] integerValue] == 2000) {
                                [MeiBaiConfigFile setCurrentProject:ENHANCE];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [SVProgressHUD showSuccessWithStatus:@"美白计划调整成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                });
                            } else{
                                [SVProgressHUD showErrorWithStatus:@"美白计划调整失败，请稍后再试"];
                            }
                            
                        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"网络出错"];
                        }];
                        
                    }];
                    
                }
                
            } else if (answer1 == 2) {
                //提示修改温柔计划
                if (project != GENTLE  && project != KEEP) {
                    [self alertUserToModifyProject:GENTLE withAlertHandler:^{
                        //
                        [SVProgressHUD showWithStatus:@"正在调整计划"];
                        
                        [NetworkManager ModifyProject:@"C" WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSLog(@"response %@",responseObject);
                            if ([responseObject[@"status"] integerValue] == 2000) {
                                [MeiBaiConfigFile setCurrentProject:GENTLE];
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [SVProgressHUD showSuccessWithStatus:@"美白计划调整成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                });
                            } else{
                                [SVProgressHUD showErrorWithStatus:@"美白计划调整失败，请稍后再试"];
                            }
                            
                        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"网络出错"];
                        }];
                        
                    }];
                    
                }
            } else if (answer1 != 2 && answer2 == 0 && answer2 == 1) {
                //提示修改温柔计划
                if (project != GENTLE  && project != KEEP) {
                    [self alertUserToModifyProject:GENTLE withAlertHandler:^{
                        //
                        [SVProgressHUD showWithStatus:@"正在调整计划"];
                        
                        [NetworkManager ModifyProject:@"C" WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSLog(@"response %@",responseObject);
                            if ([responseObject[@"status"] integerValue] == 2000) {
                                [MeiBaiConfigFile setCurrentProject:GENTLE];
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [SVProgressHUD showSuccessWithStatus:@"美白计划调整成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                });
                            } else{
                                [SVProgressHUD showErrorWithStatus:@"美白计划调整失败，请稍后再试"];
                            }
                            
                        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"网络出错"];
                        }];
                        
                        
                    }];
                    
                }
            } else{
                //提示修改至标准计划
                if (project != STANDARD  && project != KEEP) {
                    [self alertUserToModifyProject:STANDARD withAlertHandler:^{
                        //
                        [SVProgressHUD showWithStatus:@"正在调整计划"];
                        
                        [NetworkManager ModifyProject:@"A" WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSLog(@"response %@",responseObject);
                            if ([responseObject[@"status"] integerValue] == 2000) {
                                [MeiBaiConfigFile setCurrentProject:STANDARD];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [SVProgressHUD showSuccessWithStatus:@"美白计划调整成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                });
                            } else{
                                [SVProgressHUD showErrorWithStatus:@"美白计划调整失败，请稍后再试"];
                            }
                            
                        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"网络出错"];
                        }];
                        
                        
                    }];
                    
                }
            }
            

            

        } else{
            [view didCHangeColorType:Normal];
        }
    }];
    
}

-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
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

typedef void(^AlertBlock)(void);

-(void)alertUserToModifyProject:(MEIBAI_PROJECT)project withAlertHandler:(AlertBlock)block{
    
    NSString *string = @"根据您的选择，是否调整至标准计划";
    
    NSString *actionString = @"调整至加强计划";
    
    if (project == ENHANCE) {
        //加强
        string = @"根据您的选择，是否调整至加强计划";
        
        actionString = @"调整至加强计划";
        
        
    } else if (project == GENTLE) {
        //温柔
        string = @"根据您的选择，是否调整至温柔计划";
        actionString = @"调整至温柔计划";
        
        
    } else if (project == STANDARD) {
        //标准
        string = @"根据您的选择，是否调整至标准计划";
        actionString = @"调整至标准计划";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (block) {
            block();
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
