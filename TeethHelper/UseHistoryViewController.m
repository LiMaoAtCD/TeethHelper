//
//  UseHistoryViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "UseHistoryViewController.h"
#import "UseHistoryCell.h"
#import "Utils.h"

@interface UseHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *useHistoryItems;

@end

@implementation UseHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"使用记录" onViewController:self];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.useHistoryItems.count;
    return 4;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UseHistoryCell" forIndexPath:indexPath];
    if (indexPath.row != 0) {
        cell.topLine.hidden = YES;
    }
    
    return cell;
}

@end
