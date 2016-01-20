//
//  ModifyViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ModifyViewController.h"
#import "Utils.h"
#import <SVProgressHUD.h>
#import "NetworkManager.h"
@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;

@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * confirmPassword;


@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"修改密码" onViewController:self];
    [self configTextFields];
    [self.passwordTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];

}

-(void)configTextFields{
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    self.confirmTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请再次输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
}


-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submit:(id)sender {
    BOOL isvalid = [self validityCheck];
    
    if (isvalid) {
        //TODO: 修改密码
        [SVProgressHUD showWithStatus:@"正在修改"];
        
        [NetworkManager ForgetPassword:self.phone verifyCode:self.verifyCode password:self.password withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                //修改成功
                
                [SVProgressHUD showSuccessWithStatus:@"密码修改成功，请重新登录"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            } else if([responseObject[@"status"] integerValue] == 3001){
                [SVProgressHUD showErrorWithStatus:@"该手机号尚未注册"];
            } else if ([responseObject[@"status"] integerValue] == 1008){
                [SVProgressHUD showErrorWithStatus:@"验证码错误"];
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络开小差了，请检查网络是否通畅"];
        }];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)validityCheck{
    
    if (![Utils isValidPassword:self.password]) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位字母或数字"];
        return NO;
    } else if (![Utils isValidPassword:self.confirmPassword]) {
        [SVProgressHUD showErrorWithStatus:@"确认密码为6-16位字母或数字"];
        return NO;
    } else if (![self.password isEqualToString:self.confirmPassword]) {
        [SVProgressHUD showErrorWithStatus:@"二次密码输入不一致"];
        return NO;
    }
    
 
    return YES;
}

-(void)textFieldEditChanged:(UITextField *)textField{
    
    if (textField == self.passwordTextField) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
        self.password = textField.text;
        
        NSLog(@"password: %@",_password);
    } else{
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
        self.confirmPassword = textField.text;
        
        NSLog(@"confirm password : %@",_confirmPassword);
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
