//
//  LoginViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "LoginViewController.h"
#import "Utils.h"
#import "AccountManager.h"
#import <Masonry.h>
#import "SplashViewController.h"
#import <SVProgressHUD.h>
#import "NetworkManager.h"

@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"登录" onViewController:self];
    self.navigationItem.leftBarButtonItem = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self.phoneTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self configTextFields];
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"_first_launch"]) {

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"_first_launch"]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"_first_launch"];
                [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [self addSplashView];
    }
    
}

-(void)configTextFields{
    
    
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
}

-(void)dismissKeyboard{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    
    BOOL isValid = [self validityCheck];
    
    if (isValid) {
        [SVProgressHUD showWithStatus:@"登录中"];
        
        //TODO:登录逻辑
        [NetworkManager LoginByUsername:self.phone password:self.password withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                //注册成功
                NSDictionary *data = responseObject[@"data"];
                NSDictionary *temp = data[@"user"];
                
                
                //token
                if ([[data allKeys] containsObject:@"accessToken"]) {
                    
                    [AccountManager setTokenID:data[@"accessToken"]];
                }
                if ([[temp allKeys] containsObject:@"nickName"]) {
                    //姓名
                    [AccountManager setName:temp[@"nickName"]];
                }
                if ([[temp allKeys] containsObject:@"sex"]) {
                    //性别
                    [AccountManager setgender:temp[@"sex"]];
                }
                if ([[temp allKeys] containsObject:@"birthday"]) {
                    //生日
                    [AccountManager setBirthDay:temp[@"birthday"]];
                }
                if ([[temp allKeys] containsObject:@"username"]) {
                    //手机号
                    [AccountManager setCellphoneNumber:temp[@"username"]];
                }
                if ([[temp allKeys] containsObject:@"address"]) {
                    //地址
                    [AccountManager setAddress:temp[@"address"]];
                }
                if ([[temp allKeys] containsObject:@"avatar"]) {
                    //头像
                    [AccountManager setAvatarUrlString:temp[@"avatar"]];
                }
                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
            
                
            } else if ([responseObject[@"status"] integerValue] == 1001){
                //校验出错
                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
                
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
        }];
        
    }
}

-(void)textFieldEditChanged:(UITextField *)textField{
    
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        self.phone = textField.text;
        
        NSLog(@"phone: %@",_phone);
    } else{
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
        self.password = textField.text;
        NSLog(@"password: %@",_password);

    }

}

-(void)addSplashView{
    
    SplashViewController *splashVC = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    
    [self presentViewController:splashVC animated:NO completion:^{
        
    }];

}

-(BOOL)validityCheck{
//    if (self.phone is) {
//        <#statements#>
//    }
    
    if (![Utils isValidCellphoneNumber:self.phone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return NO;
    }
    
    if(![Utils isValidPassword:self.password]){
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位字母或数字"];
        return NO;
    }
    
    
    return YES;
}

@end
