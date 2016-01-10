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
#import "TLCityPickerController.h"
#import "GLDPopPicker.h"


@interface AddressViewController ()<TLCityPickerDelegate,GLDPopPickerDataSouce, GLDPopPickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
//@property (nonatomic, copy) NSString *address;

@property (weak, nonatomic) IBOutlet UIView *addressPrefixView;

@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (strong, nonatomic) GLDPopPicker *popPicker;


@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"编辑" onViewController:self];
    [self configRightNavigationItem];
    [self.addressTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    self.addressTextField.text = self.address;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCity)];
    
    [self.addressPrefixView addGestureRecognizer:tap];
    
    GLDPopPicker *popPicker = [[GLDPopPicker alloc] init];
    popPicker.dataSource = self;
    popPicker.delegate = self;
    [self.view addSubview:popPicker];
    _popPicker = popPicker;

}


-(void)selectCity{
//    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
//    [cityPickerVC setDelegate:self];
//    
//    cityPickerVC.locationCityID = @"1400010000";
//    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
//    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
//    
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
//        
//    }];

    [_popPicker showAddressPicker];

}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
//    [self.cityPickerButton setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
                
            }else if ([responseObject[@"status"] integerValue] == 1012){
                
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

#pragma mark - GLDPopPicker delegate

- (void)cancelAction
{
    NSLog(@"cancel");
}

- (void)doneAction
{
    NSLog(@"done");
}

- (void)popPicker:(GLDPopPicker *)popPicker didSelectedAddress:(ChinaAddressModel *)address
{
    self.provinceLabel.text = address.province;
    self.cityLabel.text = address.city;

//    _address = [NSString stringWithFormat:@"%@ %@ %@",address.province, address.city, address.district];
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    //    [self.tableView reloadData];
    
    
    
}
@end
