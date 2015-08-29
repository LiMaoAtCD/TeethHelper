//
//  PostToSocialController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/29.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "PostToSocialController.h"
#import "Utils.h"

#import <Masonry.h>
@interface PostToSocialController ()

@property (strong, nonatomic) UIImageView *postImageView;

@end

@implementation PostToSocialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [Utils ConfigNavigationBarWithTitle:@"分享至社区" onViewController:self];
    [self configRightNavigationItem];
    
    
    if (self.firstImage) {
        //如果不是第一次
        
        CGFloat width  = 278.0;
        CGFloat height = width * self.secondImage.size.height / self.secondImage.size.width;
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, height + 50.0), YES, [UIScreen mainScreen].scale);
        
        [self.secondImage drawInRect:CGRectMake(14, 8, width, height)];

        [[UIColor whiteColor] set]; //set the desired background color
        UIRectFill(CGRectMake(0.0, 0.0, 300, height + 50.0));
        
        [self.secondImage drawInRect:CGRectMake(14, 8, width, height)];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label1.text = @"您当前的牙齿色阶为";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont boldSystemFontOfSize:16];
        
        [label1 drawTextInRect:CGRectMake(49, height + 12, 144, 20)];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label2.text = self.levelString;
        label2.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        label2.font = [UIFont systemFontOfSize:17];
        
        [label2 drawTextInRect:CGRectMake(201, height + 12, 42, 21)];
        
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label3.text = [NSString stringWithFormat:@"击败了全国%@的人",self.beatRateString];
        
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:14];
        
        [label3 drawTextInRect:CGRectMake(49, height + 31, 201, 21)];
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        self.postImageView = [[UIImageView alloc] initWithImage:temp];
        
        [self.view addSubview:self.postImageView];
        //        self.postImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.postImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.postImageView.layer.borderWidth = 1.0;
        
        
        
        CGFloat imageViewwidth = [UIScreen mainScreen].bounds.size.width / 2;
        CGFloat imageViewHeight = (height + 50) * imageViewwidth / 300.0;
        
        
        
        [self.postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_centerX);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(72);
            make.height.equalTo(@(imageViewHeight));
        }];

        
    } else{
        
        CGFloat width  = 278.0;
        CGFloat height = width * self.secondImage.size.height / self.secondImage.size.width;
        
        
       
        //开始
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, height * 2 + 100), YES, [UIScreen mainScreen].scale);
        
        //背景颜色为白色
        [[UIColor whiteColor] set];
        UIRectFill(CGRectMake(0.0, 0.0, 300, height * 2 + 100));
        
        
        //使用前
        UILabel *use_before_label = [[UILabel alloc] initWithFrame:CGRectZero];
        
        use_before_label.text = @"使用前";
        use_before_label.textAlignment = NSTextAlignmentCenter;
        use_before_label.font = [UIFont systemFontOfSize:14.0];
        use_before_label.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        [use_before_label drawTextInRect:CGRectMake(125, 8, 51, 21)];
        
        
        //第一张图片
        [self.firstImage drawInRect:CGRectMake(14, 34, width, height)];
        
        //使用后
        UILabel *use_after_label = [[UILabel alloc] initWithFrame:CGRectZero];
        
        use_after_label.text = @"使用后";
        use_after_label.textAlignment = NSTextAlignmentCenter;
        use_after_label.font = [UIFont systemFontOfSize:14.0];
        use_after_label.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        
        [use_after_label drawTextInRect:CGRectMake(129, height + 30, 42, 18)];

        //第二张图片
        [self.secondImage drawInRect:CGRectMake(14, height + 50, width, height)];
        
        
        
        
        //
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label1.text = @"您当前的牙齿色阶为";
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont boldSystemFontOfSize:16];
        
        [label1 drawTextInRect:CGRectMake(50, height * 2 + 50, 144, 20)];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label2.text = self.levelString;
        label2.textColor = [UIColor colorWithRed:99./255 green:181./255 blue:185./255 alpha:1.0];
        label2.font = [UIFont systemFontOfSize:17];
        
        [label2 drawTextInRect:CGRectMake(201, height * 2 + 50, 42, 21)];
        
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label3.text = [NSString stringWithFormat:@"击败了全国%@的人",self.beatRateString];
        
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:14];
        
        [label3 drawTextInRect:CGRectMake(49, height * 2 + 75, 201, 21)];
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        self.postImageView = [[UIImageView alloc] initWithImage:temp];
        
        [self.view addSubview:self.postImageView];

        self.postImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.postImageView.layer.borderWidth = 1.0;
        
        
        
        CGFloat imageViewwidth = [UIScreen mainScreen].bounds.size.width / 2;
        CGFloat imageViewHeight = ( 2 * height + 100) * imageViewwidth / 300;
        
        
        
        [self.postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_centerX);
            make.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(72);
            make.height.equalTo(@(imageViewHeight ));
        }];

        
        
    }
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configRightNavigationItem{
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,25)];
    
    [popButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"发布" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
    
    [popButton addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:popButton];
    
}


-(void)post:(id)sender{

}
@end
