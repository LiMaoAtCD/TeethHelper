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

@interface PersonalInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *item;

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.item =@[@"头像",@"姓名",@"性别",@"出生年月",@"手机号",@"通讯地址"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.avatarImageView.image = [UIImage imageNamed:@""];
        return cell;
    } else{
        InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
        cell.titleLabel.text =self.item[indexPath.row];
    
        
        return cell;
    }
    
    
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
