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
#import "WXApi.h"
#import "WXApiManager.h"
@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@property (weak, nonatomic) IBOutlet UIButton *wexinLoginButton;


@end


//static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact,snsapi_userinfo";
static NSString *kAuthScope = @"snsapi_userinfo";

static NSString *kAuthOpenID = @"wxc213130fe4f9b110";
static NSString *kAuthState = @"xxx";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"登录" onViewController:self];
//    self.navigationItem.leftBarButtonItem = nil;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self.phoneTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self configTextFields];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
 
    
    if (![WXApi isWXAppInstalled]) {
        self.wexinLoginButton.hidden = YES;
    }
    
    [self.wexinLoginButton addTarget:self action:@selector(weixinLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userWeixinlogin:) name:@"weixinlogin" object:nil];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinlogin" object:nil userInfo:dic];

}
-(void)userWeixinlogin:(NSNotification*)notification {
    NSDictionary *dic = notification.userInfo;
    NSLog(@"%@",dic);
    [SVProgressHUD showWithStatus:@"登录中"];
    [NetworkManager ThirdLoginByThirdID:dic[@"unionid"] provider:@"WEIXIN" userAliasName:dic[@"nickname"] userAvatar:dic[@"headimgurl"] withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                
                
                NSString *yearString = [temp[@"birthday"] substringWithRange:NSMakeRange(0, 4)];
                NSString *monthString = [temp[@"birthday"] substringWithRange:NSMakeRange(5, 2)];
                NSString *dayString = [temp[@"birthday"] substringWithRange:NSMakeRange(8, 2)];
                
                NSString *tempBirthday = [NSString stringWithFormat:@"%@年%@月%@日",yearString,monthString,dayString];
                
                
                [AccountManager setBirthDay:tempBirthday];
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
            
            [SVProgressHUD dismiss];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
            
            
        } else if ([responseObject[@"status"] integerValue] == 1001){
            //校验出错
            //                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
            [SVProgressHUD dismiss];
            [Utils showAlertMessage:@"密码错误" onViewController:self withCompletionHandler:nil];
            
        } else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        } else{
            [SVProgressHUD showErrorWithStatus:@"服务器内部错误"];

        }

    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
    

}
-(void)weixinLogin:(id)sender{
    [self sendAuthRequestScope:kAuthScope State:kAuthState OpenID:kAuthOpenID InViewController:self];
}

-(void)configTextFields{
    
    
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    
    self.passwordTextField.returnKeyType = UIReturnKeyDone;

}

-(void)dismissKeyboard{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];

}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.passwordTextField.text = nil;
    self.phoneTextField.text = nil;
    self.password = nil;
    self.phone = nil;
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
                    
                    
                    NSString *yearString = [temp[@"birthday"] substringWithRange:NSMakeRange(0, 4)];
                    NSString *monthString = [temp[@"birthday"] substringWithRange:NSMakeRange(5, 2)];
                    NSString *dayString = [temp[@"birthday"] substringWithRange:NSMakeRange(8, 2)];

                    NSString *tempBirthday = [NSString stringWithFormat:@"%@年%@月%@日",yearString,monthString,dayString];
                    
                    
                    [AccountManager setBirthDay:tempBirthday];
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
                
                [SVProgressHUD dismiss];
                [AccountManager setPassword:self.password];

                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
            
                
            } else if ([responseObject[@"status"] integerValue] == 1001){
                //校验出错
//                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
                [SVProgressHUD dismiss];
                [Utils showAlertMessage:@"密码错误" onViewController:self withCompletionHandler:nil];
                
            } else if ([responseObject[@"status"] integerValue] == 1012){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
        }];
        
    }
}

- (NSDate *)dateFromString:(NSString *)string {
    if (!string) {
        return nil;
    }
    //Wed Mar 14 16:40:08 +0800 2012
    static NSDateFormatter *dateformatter=nil;
    if(dateformatter==nil){
        dateformatter = [[NSDateFormatter alloc] init];
        NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [dateformatter setTimeZone:tz];
        [dateformatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    }
    return [dateformatter dateFromString:string];
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



-(BOOL)validityCheck{
//    if (self.phone is) {
//    }
    
    if (self.phone == nil || [self.phone isEqualToString:@""]) {
        [Utils showAlertMessage:@"请输入正确的手机号码" onViewController:self withCompletionHandler:nil];
    }
    
    if (![Utils isValidCellphoneNumber:self.phone]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        
        [Utils showAlertMessage:@"请输入正确的手机号码" onViewController:self withCompletionHandler:^{
            
            self.phone = nil;
            [self.phoneTextField becomeFirstResponder];
            
        }];
        
        return NO;
    }
    
    if (self.password == nil || [self.password isEqualToString:@""]) {
        [Utils showAlertMessage:@"请输入密码" onViewController:self withCompletionHandler:nil];
    }

    
    if(![Utils isValidPassword:self.password]){
//        [SVProgressHUD showErrorWithStatus:@"密码为6-16位字母或数字"];
        
        [Utils showAlertMessage:@"密码为6-16位字母或数字" onViewController:self withCompletionHandler:^{
            
            self.password = nil;
            [self.passwordTextField becomeFirstResponder];
        }];
        
        
        
        return NO;
    }
    
    
    return YES;
}


-(BOOL)sendAuthRequestScope:(NSString *)scope
                       State:(NSString *)state
                      OpenID:(NSString *)openID
            InViewController:(UIViewController *)viewController {
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = scope; // @"post_timeline,sns"
    req.state = state;
    req.openID = openID;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:[WXApiManager sharedManager]];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
