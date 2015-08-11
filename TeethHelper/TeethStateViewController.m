//
//  TeethStateViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "TeethStateViewController.h"
#import "Utils.h"
#import "TeethStateCell.h"

#import "TeethDetailOneController.h"
#import "TeethDetailTwoController.h"
#import "TeethDetailThreeController.h"

@interface TeethStateViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@property (strong, nonatomic) NSArray *items;

@end

@implementation TeethStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.items = @[@"牙齿健康状况",@"牙齿是否对冷、酸敏感",@"美白意愿"];
    self.tableVIew.tableFooterView = [UIView new];
    
    [Utils ConfigNavigationBarWithTitle:@"牙齿状况" onViewController:self];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeethStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeethStateCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.items[indexPath.row];
//    cell.contentLabel.text = 
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    if (indexPath.row == 0) {
        TeethDetailOneController *oneVC = [sb instantiateViewControllerWithIdentifier:@"TeethDetailOneController"];
        [self.navigationController pushViewController:oneVC animated:YES];
    } else if(indexPath.row == 1){
        TeethDetailTwoController *twoVC = [sb instantiateViewControllerWithIdentifier:@"TeethDetailTwoController"];
        [self.navigationController pushViewController:twoVC animated:YES];
    } else{
        TeethDetailThreeController *threeVC = [sb instantiateViewControllerWithIdentifier:@"TeethDetailThreeController"];
        [self.navigationController pushViewController:threeVC animated:YES];

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
