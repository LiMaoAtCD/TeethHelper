//
//  AddressViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AddressViewController.h"
#import "Utils.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>
#import "AccountManager.h"

@interface AddressViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
//@property (nonatomic, copy) NSString *address;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"编辑" onViewController:self];
    [self configRightNavigationItem];
    [self.addressTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    self.addressTextField.text = self.address;
    
}
-(void)textFieldEditChanged:(UITextField *)textField{
    
    if (textField.text.length > 50) {
        textField.text = [textField.text substringToIndex:50];
    }
    self.address = textField.text;
    
    NSLog(@"address: %@",_address);
}

-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save:(UIButton *)button{
    [self.addressTextField resignFirstResponder];
    
    if (self.address == nil) {
        [SVProgressHUD showErrorWithStatus:@"地址不可为空"];
    } else{
        [SVProgressHUD showWithStatus:@"正在修改"];
        [NetworkManager EditUserNickName:nil sex:nil birthday:nil address:self.address withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [AccountManager setAddress:self.address];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else if ([responseObject[@"status"] integerValue] == 1002){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
            
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
        }];
    }

}

-(void)configRightNavigationItem{
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,20)];
    
    [popButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"保存" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0]}] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popButton];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
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
