//
//  PersonalInfoViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "AvatarCell.h"
#import "InfoCell.h"

#import "GenderViewController.h"
#import "AvatarViewController.h"
#import "BirthDayViewController.h"

#import "NameInfoViewController.h"
#import "PhoneInfoViewController.h"
#import "AddressViewController.h"
#import "NewPasswordViewController.h"

#import "Utils.h"
#import "AccountManager.h"
#import <UIImageView+WebCache.h>

#import "NetworkManager.h"
#import <SVProgressHUD.h>

@interface PersonalInfoViewController ()<UITableViewDelegate, UITableViewDataSource,BirthDaySelectionDelegate,GenderSelectionDelegate,AvatarSelectionDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *item;
@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.item =@[@"头像",@"昵称",@"性别",@"出生年月",@"手机号",@"通讯地址",@"修改密码"];
    [Utils ConfigNavigationBarWithTitle:@"个人信息" onViewController:self];
    
    self.tableView.backgroundView = [UIView new];
    
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AvatarCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"头像";
        
        if ([AccountManager getAvatarUrlString]) {
//            cell.avatarImageView.image = [UIImage imageNamed:@""];
            NSURL *imgURL =[NSURL URLWithString:[AccountManager getAvatarUrlString]];
            [cell.avatarImageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"img_head"]];
        } else{
            cell.avatarImageView.image = [UIImage imageNamed:@"img_head"];
        }
        return cell;
        
    } else{
        InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        cell.titleLabel.text =self.item[indexPath.row];
        
        if (indexPath.row == 1) {
            //姓名
            cell.contentLabel.text = [AccountManager getName];
        } else if (indexPath.row == 2){
            //性别
            NSString * gender = [AccountManager getGender];

            if (gender) {
                cell.contentLabel.text = gender;
            } else{
                cell.contentLabel.text = @"";
            }

        } else if (indexPath.row == 3){
            //出生年月
            NSString *birthday = [AccountManager getBirthday];
            
            cell.contentLabel.text = birthday;
            
        } else if (indexPath.row == 4){
//            手机号
            NSString *phone = [AccountManager getCellphoneNumber];
            
            cell.contentLabel.text = phone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.contentLabel.textColor = [UIColor lightGrayColor];
            
        } else if (indexPath.row == 5){
//            地址
            NSString *address = [AccountManager getAddress];
            cell.contentLabel.text = address;
        } else {
            
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    
    switch (indexPath.row) {
        case 0:
        {
            //
            AvatarViewController *avatar = [sb instantiateViewControllerWithIdentifier:@"AvatarViewController"];
            avatar.delegate = self;
            [self showDetailViewController:avatar sender:self];
        }
            break;
        case 1:{
            //姓名
            NameInfoViewController *nameVC = [sb instantiateViewControllerWithIdentifier:@"NameInfoViewController"];
            [self.navigationController pushViewController:nameVC animated:YES];
        }
            break;
        case 2:{
            //性别
            GenderViewController *genderVC = [sb instantiateViewControllerWithIdentifier:@"GenderViewController"];
            genderVC.delegate = self;
            [self showDetailViewController:genderVC sender:self];

        }
            break;
        case 3:{
            //出生年月
            
            BirthDayViewController *bVC = [sb instantiateViewControllerWithIdentifier:@"BirthDayViewController"];
            bVC.delegate = self;
            [self showDetailViewController:bVC sender:self];

        }
            break;
//        case 4:{
//            //手机号
//            PhoneInfoViewController *phoneVC = [sb instantiateViewControllerWithIdentifier:@"PhoneInfoViewController"];
//            [self.navigationController pushViewController:phoneVC animated:YES];
//        }
//            break;
        case 5:{
            //地址
            AddressViewController *addressVC = [sb instantiateViewControllerWithIdentifier:@"AddressViewController"];
            addressVC.address = [AccountManager getAddress];
            
            [self.navigationController pushViewController:addressVC animated:YES];

        }
            break;
            case 6:
        {
            NewPasswordViewController *newPassword = [sb instantiateViewControllerWithIdentifier:@"NewPasswordViewController"];
            
            [self.navigationController pushViewController:newPassword animated:YES];
        }

            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didSelectedBirthDay:(NSDate *)birthday{
    NSLog(@"%@",birthday);
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
        [formatter setDateFormat:@"yyyy-MM-dd 00:00:00"];
    
    //上传至服务器的时间格式
        NSString *date = [formatter stringFromDate:birthday];
    
    
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    //保存本地的时间格式
        NSString *birthdayString = [formatter stringFromDate:birthday];
    
    [SVProgressHUD showWithStatus:@"正在修改"];
    [NetworkManager EditUserNickName:nil sex:nil birthday:date address:nil withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 2000) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [AccountManager setBirthDay:birthdayString];
            [self.tableView reloadData];
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        } else{
            [SVProgressHUD showSuccessWithStatus:@"修改失败"];

        }
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
    }];
    
}
-(void)didSelectGenderType:(GenderType)type{
    if (type == MALE) {
        [NetworkManager EditUserNickName:nil sex:@"男" birthday:nil address:nil withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                [AccountManager setgender:@"男"];
                [self.tableView reloadData];
            }else if ([responseObject[@"status"] integerValue] == 1012){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
            }
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    } else{
        [NetworkManager EditUserNickName:nil sex:@"女" birthday:nil address:nil withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                [AccountManager setgender:@"女"];
                [self.tableView reloadData];

            }else if ([responseObject[@"status"] integerValue] == 1012){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
            }


        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

#pragma mark - 头像选择
-(void)didSelectedPhoto:(PhotoType)type{
    _picker = [[UIImagePickerController alloc] init];

    if (type == Camera) {
        //调用系统相机
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] ) {
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        
    } else {
        //调用相册
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    _picker.delegate = self;
    
    _picker.allowsEditing = YES;
    
    [self showDetailViewController:_picker sender:self];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    @autoreleasepool {
        
        UIImage *tempImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAvatar" object:@{@"avatar": tempImage}];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [SVProgressHUD showWithStatus:@"正在上传头像"];
        [NetworkManager UploadAvatarImageFile:tempImage withCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"status"] integerValue] == 2000) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                
                [AccountManager setAvatarUrlString:responseObject[@"data"]];
                
                [self.tableView reloadData];
            }else if ([responseObject[@"status"] integerValue] == 1012){
                
                [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
                
            } else{
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
            }
            
        } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络出错啦"];
        }];
        

    }
    
}


@end
