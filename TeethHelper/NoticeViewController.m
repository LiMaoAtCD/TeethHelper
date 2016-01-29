//
//  NoticeViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "NoticeViewController.h"
#import "Utils.h"
#import "NoticeTableViewCell.h"

@interface NoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *items;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"注意事项" onViewController:self];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.items =@[
                  @"美白过程推荐从标准计划开始,可根据个人的需要及牙齿的反应调整增加或减少次数及疗程",
                  @"在使用过程中或结束后出现轻度的酸胀感，是正常现象，可继续进行疗程。如果出现较为剧烈的酸痛感，需要暂停美白过程，建议咨询口腔科医师后再决定是否继续使用",
                  @"检测牙齿白度时为保证效果，最好在白天光线充足的条件下拍照。每次拍照建议保持相同的光线条件",
                  @"建议使用品牌厂家的手机充电器对电池进行充电",
                  @"打开包装后应在48小时内用完"];
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
    return 5;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell" forIndexPath:indexPath];
    
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.contentLabel.text = self.items[indexPath.row];
    
    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    
    return cell;
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
