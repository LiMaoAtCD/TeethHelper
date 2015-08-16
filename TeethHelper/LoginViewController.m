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
        
        
        
            [self dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
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
