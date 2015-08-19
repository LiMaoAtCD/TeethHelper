//
//  PhoneInfoViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "PhoneInfoViewController.h"
#import "Utils.h"
#import <SVProgressHUD.h>
#import "NetworkManager.h"
@interface PhoneInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (nonatomic, copy) NSString *phone;
@end

@implementation PhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"编辑" onViewController:self];
    [self configRightNavigationItem];
    [self.phoneTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
}
-(void)textFieldEditChanged:(UITextField *)textField{
    
    if (textField.text.length > 1) {
        textField.text = [textField.text substringToIndex:11];
    }
    self.phone = textField.text;
    
    NSLog(@"phone: %@",_phone);
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save:(UIButton *)button{
    [self.phoneTextField resignFirstResponder];
    
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
