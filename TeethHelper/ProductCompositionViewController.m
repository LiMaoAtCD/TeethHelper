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

#import "CompositionDetailViewController.h"
#import "QRCodeAnimator.h"
#import "QRCodeDismissAnimator.h"

#import "ProductConfigFile.h"
#import <UIImageView+WebCache.h>

@interface ProductCompositionViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *Detailitems;


@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;



@end

@implementation ProductCompositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"产品组成" onViewController:self];
    self.items = @[@"冷光牙托",@"电源控制器",@"存放基座",@"充电线",@"美白胶",@"测白标尺",@"刷头",@"挂绳",@"旅行包"];
    self.Detailitems = @[@"按照人体工程学设计外形，置入口腔并与牙齿紧密贴合，外层为柔软的高分子材料，保证舒适卫生。内置光源发出480nm的特定的冷光有效激活美白活性，增强美白效果",
                         @"内置锂电池，通过标准的苹果lightening接口对冷光牙托进行供电。每次治疗结束以后(8分钟)会自动停止。配备LED显示美白剩余时间",
                         @"方便、卫生地存储各个部件在卫生间、化妆间等常用场所",
                         @"标准苹果lightening充电线",
                         @"32Space Pearl美白胶采用独特配方及纳米技术提供有效美白效果。抗过敏及水果香型设计让整个过程方便，舒适，在享受中完成美白",
                         @"测量牙齿白度时将牙齿显露出来便于拍摄,并提供白度标准做判定",
                         @"使用时套在去除皇冠头的美白胶管头部，便于将胶均匀的涂刷至牙齿表面。",
                         @"美白时用挂绳方便的将电源控制器悬挂使用",
                         @"旅行时便于携带全套美白组件"];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0)];
    
    [self.view addSubview:_scrollView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:_imageView];
    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        self.scrollView.contentSize = CGSizeMake(320, 1462.0 / 2);
        
        
        self.imageView.image = [UIImage imageNamed:@"zucheng_5"];
        self.imageView.frame = CGRectMake(0, 0, 320, 1462.0 / 2);
        
        
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
//        self.scrollView.contentSize = CGSizeMake(375, (1713.0 + 100) / 2);
        self.scrollView.contentSize = CGSizeMake(375, 1713.0 / 2);

        self.imageView.image = [UIImage imageNamed:@"zucheng_6"];
        self.imageView.frame = CGRectMake(0, 0, 375, 1713.0 / 2);
        
    } else {
        
        self.scrollView.contentSize = CGSizeMake(1242.0 / 3, 2837.0 / 3);
        
        self.imageView.image = [UIImage imageNamed:@"zucheng_7"];
        self.imageView.frame = CGRectMake(0, 0, 1242.0 /3, 2837.0 / 3);
    }


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

    
    if (indexPath.row == 4) {
        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:[ProductConfigFile getMeiBaiJiaoourceThumb]] placeholderImage:[UIImage imageNamed:@"pdc_4"]];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Product" bundle:nil];
    CompositionDetailViewController *compositionVC = [sb instantiateViewControllerWithIdentifier:@"CompositionDetailViewController"];
    
    compositionVC.mainTitle = self.items[indexPath.row];
    compositionVC.content =self.Detailitems[indexPath.row];
    compositionVC.toRevealImage = [UIImage imageNamed:[NSString stringWithFormat:@"pdc_%ld",indexPath.row]];
    
    if (indexPath.row == 4) {
        compositionVC.meibaijiaoURL = [ProductConfigFile getMeiBaiJiaoource];
    }
    
  
    
    
    
    compositionVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    compositionVC.transitioningDelegate = self;
    [self showDetailViewController:compositionVC sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ViewController Transition Delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[QRCodeAnimator alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[QRCodeDismissAnimator alloc] init];
    
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
