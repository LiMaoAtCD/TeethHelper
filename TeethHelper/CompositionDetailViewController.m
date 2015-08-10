//
//  CompositionDetailViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "CompositionDetailViewController.h"

@interface CompositionDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *grayView;

@property (weak, nonatomic) IBOutlet UIView *MainView;

@end

@implementation CompositionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = self.mainTitle;
    self.imageView.image = self.toRevealImage;
    self.contentLabel.text = self.content;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    [self.grayView addGestureRecognizer:tap];
    
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    
 
    CGRect rect = [self.content boundingRectWithSize:CGSizeMake(self.contentLabel.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    NSLog(@"%f",rect.size.height);
//    self.contentLabel.bounds.size.height = rect.size.height;
    CGRect temp = self.contentLabel.frame;
    self.contentLabel.frame = CGRectMake(temp.origin.x, temp.origin.y, temp.size.width, rect.size.height);
    CGRect mainTempRect = self.MainView.bounds;
    
    self.MainView.bounds =CGRectMake(0, 0, mainTempRect.size.width, mainTempRect.size.height + rect.size.height);
//
//    [self.view layoutIfNeeded];
    
}


-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
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
