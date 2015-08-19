//
//  RegisterViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "RegisterViewController.h"
#import "Utils.h"
#import <SVProgressHUD.h>
#import "NetworkManager.h"
#import "AccountManager.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *readButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *activeField;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *verifyCode;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *confirmPassword;


@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isAgreeProtocol;



@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"注册" onViewController:self];

    [self registerForKeyboardNotifications];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.scrollView addGestureRecognizer:tap];
    [self configTextFields];
    
    //验证码按钮
    [self.verifyCodeButton addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.verifyCodeButton setBackgroundImage:[UIImage imageNamed:@"btn_code_normal"] forState:UIControlStateNormal];
    
    //同意协议按钮
    [self.readButton addTarget:self action:@selector(agreeProtocol:) forControlEvents:UIControlEventTouchUpInside];
    self.readButton.tag = 0;
    self.isAgreeProtocol = YES;
}

-(void)configTextFields{
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    self.verifyCodeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    self.nickNameTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入昵称" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
     self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
     self.confirmTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请再次输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    
    
   [self.nickNameTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
   [self.phoneTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
   [self.verifyCodeTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
   [self.passwordTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.confirmTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerUser:(id)sender {
    BOOL isvalid = [self validityCheck];
    if (isvalid) {
        //TODO: 请求注册
        
        if (self.isAgreeProtocol) {
            
            [SVProgressHUD showWithStatus:@"正在注册"];
            [NetworkManager RegisterByNickname:self.name phone:self.phone password:self.password verifyCode:self.verifyCode withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                    
                    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                    });
                    
                } else if ([responseObject[@"status"] integerValue] == 1008){
                    //校验出错
                    [SVProgressHUD showErrorWithStatus:@"验证码错误"];

                } else if ([responseObject[@"status"] integerValue] == 3002) {
                    //手机号已被注册
                    [SVProgressHUD showErrorWithStatus:@"该手机号码已经注册"];
                }
                
                
            } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
            }];
        } else{
            //
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请先同意xxx协议" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            [alert addAction:action];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark - 键盘相关处理
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //    UIEdgeInsets contentInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

-(void)dismissKeyboard{
    [self.nickNameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
    
}

#pragma mark - 获取验证码
-(void)getVerifyCode:(id)sender{
    if (![Utils isValidCellphoneNumber:self.phone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        
    } else {
        _count = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
        [self.timer fire];
        
        [SVProgressHUD showWithStatus:@"正在获取验证码"];

        [NetworkManager FetchVerifyCode:self.phone withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                [SVProgressHUD showSuccessWithStatus:@"验证码获取成功"];
            } else if ([responseObject[@"status"] integerValue] == 3002){
                [SVProgressHUD showErrorWithStatus:@"该手机号码已经注册"];
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error %@",error);
            [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
        }];
    }
}

-(void)timerCount:(id)sender{
    _count--;
    
    if (_count > 0) {
        [self.verifyCodeButton setTitle:[NSString stringWithFormat:@"%ld S",self.count] forState:UIControlStateNormal];
        //        [self.verifyCodeButton setBackgroundImage:[UIImage imageNamed:@"btn_code_pressed"] forState:UIControlStateNormal];
        self.verifyCodeButton.userInteractionEnabled = NO;
    } else{
        
        [self.verifyCodeButton setTitle:@"重发验证码" forState:UIControlStateNormal];
        //        [self.verifyCodeButton setBackgroundImage:[UIImage imageNamed:@"btn_code_normal"] forState:UIControlStateNormal];
        
        self.verifyCodeButton.userInteractionEnabled = YES;
        [self.timer invalidate];
    }
}

#pragma mark - 注册合法性校验
-(BOOL)validityCheck{
    if (self.name == nil || [self.name isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return NO;
    }
    
    if (![Utils isValidCellphoneNumber:self.phone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return NO;
    }
    
    if (self.verifyCode == nil || [self.verifyCode isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return NO;
    }
    
    if(![Utils isValidPassword:self.password]){
        [SVProgressHUD showErrorWithStatus:@"密码为6-16位字母或数字"];
        return NO;
    }
    
    if(![Utils isValidPassword:self.confirmPassword]){
        [SVProgressHUD showErrorWithStatus:@"确认密码为6-16位字母或数字"];
        return NO;
    }
    
    if (![self.password isEqualToString:self.confirmPassword]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致,请重新输入"];
        return NO;
    }
    
    
    return YES;
}


-(void)textFieldEditChanged:(UITextField *)textField{
    
    if (textField == self.nickNameTextField) {
        //姓名
        self.name = textField.text;
        NSLog(@"name: %@",self.name);
    } else if (textField == self.phoneTextField) {
        //手机号码
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        self.phone = textField.text;
        
        NSLog(@"phone: %@",_phone);
    } else if (textField == self.verifyCodeTextField) {
        //验证码
//        if (textField.text.length > 11) {
//            textField.text = [textField.text substringToIndex:11];
//        }
        self.verifyCode = textField.text;
        NSLog(@"verify code: %@",_verifyCode);
        
    } else if(textField == self.passwordTextField){
        //密码
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
        self.password = textField.text;
        NSLog(@"password: %@",_password);

    }else{
        //再次输入密码
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
        self.confirmPassword = textField.text;
        NSLog(@"confirm password: %@",_confirmPassword);

    }

}

-(void)agreeProtocol:(UIButton*)button{
    if (button.tag == 0) {
        
        [self.readButton setBackgroundImage:[UIImage imageNamed:@"box_empty"] forState:UIControlStateNormal];
        self.readButton.tag = 1;
        self.isAgreeProtocol = NO;
        
    } else{
        
        [self.readButton setBackgroundImage:[UIImage imageNamed:@"box_Check"] forState:UIControlStateNormal];
        self.readButton.tag = 0;
        self.isAgreeProtocol = YES;

    }
}
@end
