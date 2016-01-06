//
//  NewPasswordViewController.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/6.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "Utils.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>
#import "AccountManager.h"
@interface NewPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;


@property (nonatomic, copy) NSString *oldpwd;
@property (nonatomic, copy) NSString *newpwd;


@end

@implementation NewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"修改密码" onViewController:self];

    
    [_oldPasswordTextField addTarget:self action:@selector(updateText:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextfield addTarget:self action:@selector(updateText:) forControlEvents:UIControlEventEditingChanged];

}


-(void)updateText:(UITextField *)textField{
    
    if (textField == self.oldPasswordTextField) {
        self.oldpwd = textField.text;
    } else{
        self.newpwd = textField.text;
    }
}
-(void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePassword:(id)sender {
    
    if (self.oldpwd != nil && ![self.oldpwd isEqualToString:@""]&&
        self.newpwd != nil && ![self.newpwd isEqualToString:@""]
        ) {
        
        if ([self validityCheck]) {
            [SVProgressHUD show];
            [NetworkManager editPasswordFromOld:self.oldpwd toNewPassword:self.newpwd WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"response: %@",responseObject);
                if ([responseObject[@"status"] integerValue] == 2000) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    NSDictionary *data = responseObject[@"data"];
                    //token
                    if ([[data allKeys] containsObject:@"accessToken"]) {
                        [AccountManager setTokenID:data[@"accessToken"]];
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                } else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败，请稍后再试"];
                }
            } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络出错"];
            }];
        }
    } else {
        [Utils showAlertMessage:@"密码项不能为空" onViewController:self withCompletionHandler:^{
            
        }];
    }
    
}
#pragma mark - 注册合法性校验
-(BOOL)validityCheck{
    
    if(![Utils isValidPassword:self.newpwd]){
        [Utils showAlertMessage:@"新密码为6-16位字母或数字" onViewController:self withCompletionHandler:nil];
        return NO;
    }
    
    
    
    return YES;
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
