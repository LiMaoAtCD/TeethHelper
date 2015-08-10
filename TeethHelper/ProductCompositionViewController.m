//
//  ProductCompositionViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ProductCompositionViewController.h"
#import "Utils.h"
#import "CompositionCell.h"
@interface ProductCompositionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *items;

@end

@implementation ProductCompositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"产品组成" onViewController:self];
    self.items = @[@"冷光牙托",@"电源控制器",@"存放基座",@"充电线",@"美白胶",@"测白标尺",@"刷头",@"挂绳",@"旅行包"];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompositionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompositionCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.items[indexPath.row];
    cell.contentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pdc_%ld",indexPath.row]];

    
    
    return cell;
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
