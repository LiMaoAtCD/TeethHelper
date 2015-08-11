//
//  LoginViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "LoginViewController.h"
#import "Utils.h"

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
    
    
}

-(void)textFieldEditChanged:(UITextField *)textField{
    
    if (textField == self.phoneTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringFromIndex:11];
        }
        self.phone = textField.text;
        
        NSLog(@"phone: %@",_phone);
    } else{
        if (textField.text.length > 16) {
            textField.text = [textField.text substringFromIndex:16];
        }
        self.password = textField.text;
        NSLog(@"password: %@",_password);

    }
    
//    if (textField.tag == 0) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//        self.name = textField.text;
//        
//    } else if(textField.tag == 1) {
//        //电话
//        if (textField.text.length > 11) {
//            textField.text = [textField.text substringToIndex:11];
//        }
//        self.phone = textField.text;
//        
//    } else if(textField.tag == 2) {
//        //地址
//        if (textField.text.length > 60) {
//            textField.text = [textField.text substringToIndex:60];
//        }
//        self.address = textField.text;
//        
//    } else if(textField.tag == 10) {
//        //品牌
//        if (textField.text.length > 6) {
//            textField.text = [textField.text substringToIndex:6];
//        }
//        self.TV_brand = textField.text;
//        
//    }
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
