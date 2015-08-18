//
//  ForgetPasswordViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "Utils.h"
#import "ModifyViewController.h"
#import <SVProgressHUD.h>
#import "NetworkManager.h"

@interface ForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *verifyCode;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"忘记密码" onViewController:self];
    
    [self.phoneTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self configTextFields];
    
    [self.verifyCodeButton addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.verifyCodeButton setBackgroundImage:[UIImage imageNamed:@"btn_code_normal"] forState:UIControlStateNormal];


}

-(void)configTextFields{
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
    self.verifyTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0]}];
}


-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    
    BOOL isValid = [self validityCheck];

    if (isValid) {
        //TODO: 网络请求，修改密码
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        ModifyViewController *modifyVC = [sb instantiateViewControllerWithIdentifier:@"ModifyViewController"];
        modifyVC.verifyCode = self.verifyCode;
        modifyVC.phone = self.phone;
        [self.navigationController pushViewController:modifyVC animated:YES];
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
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
        self.verifyCode = textField.text;
        NSLog(@"password: %@",_verifyCode);
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)validityCheck{
    
    if (![Utils isValidCellphoneNumber:self.phone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return NO;
    }
    
    if ([_verifyCode isEqualToString:@""]|| _verifyCode == nil) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];

        return NO;
    }
    return YES;
}

-(void)getVerifyCode:(id)sender{
    if (![Utils isValidCellphoneNumber:self.phone]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        
    } else {
        //TODO : 获取验证码
        _count = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
        [self.timer fire];
        
        [SVProgressHUD showWithStatus:@"正在获取验证码"];
        [NetworkManager FetchForgetVerifyCode:self.phone withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"] integerValue] == 2000) {
                [SVProgressHUD showSuccessWithStatus:@"验证码获取成功"];
                
                
            } else if([responseObject[@"status"] integerValue] == 3001){
                [SVProgressHUD showErrorWithStatus:@"该手机号码尚未注册"];
            }
            
            
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
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

@end
