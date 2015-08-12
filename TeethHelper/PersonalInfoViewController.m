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

#import "Utils.h"
#import "AccountManager.h"

@interface PersonalInfoViewController ()<UITableViewDelegate, UITableViewDataSource,BirthDaySelectionDelegate,GenderSelectionDelegate,AvatarSelectionDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *item;

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.item =@[@"头像",@"姓名",@"性别",@"出生年月",@"手机号",@"通讯地址"];
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
            cell.avatarImageView.image = [UIImage imageNamed:@""];
        } else{
            cell.avatarImageView.image = [UIImage imageNamed:@""];
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
            NSInteger gender = [AccountManager getGender];
            if (gender == 0) {
                cell.contentLabel.text = @"男";
            } else {
                cell.contentLabel.text = @"女";
            }

        } else if (indexPath.row == 3){
            //出生年月
            NSString *birthday = [AccountManager getBirthday];
            
            cell.contentLabel.text = birthday;
            
        } else if (indexPath.row == 4){
//            手机号
            NSString *phone = [AccountManager getCellphoneNumber];
            
            cell.contentLabel.text = phone;
            
        } else if (indexPath.row == 5){
//            地址
            NSString *address = [AccountManager getAddress];
            
            cell.contentLabel.text = address;

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
        case 4:{
            //手机号
            PhoneInfoViewController *phoneVC = [sb instantiateViewControllerWithIdentifier:@"PhoneInfoViewController"];
            [self.navigationController pushViewController:phoneVC animated:YES];
        }
            break;
        case 5:{
            //地址
            AddressViewController *addressVC = [sb instantiateViewControllerWithIdentifier:@"AddressViewController"];
            [self.navigationController pushViewController:addressVC animated:YES];

        }
            break;

            
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

-(void)didSelectedBirthDay:(NSString *)birthday{
    
}
-(void)didSelectGenderType:(GenderType)type{
    
}

#pragma mark - 头像选择
-(void)didSelectedPhoto:(PhotoType)type{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if (type == Camera) {
        //调用系统相机
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] ) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        
    } else {
        //调用相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    
    [self showDetailViewController:picker sender:self];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    @autoreleasepool {
        
        UIImage *tempImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAvatar" object:@{@"avatar": tempImage}];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        

    }
    
}


@end
