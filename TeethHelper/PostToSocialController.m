//
//  PostToSocialController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/29.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "PostToSocialController.h"
#import "Utils.h"
#import "NetworkManager.h"
#import <SVProgressHUD.h>

#import "AppDelegate.h"
#import "MainTabBarController.h"

#import <Masonry.h>
@interface PostToSocialController ()<UITextViewDelegate>

@property (strong, nonatomic) UIImageView *postImageView;
@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) UIImage *toPostImage;

@end

@implementation PostToSocialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [Utils ConfigNavigationBarWithTitle:@"分享至社区" onViewController:self];
    [self configRightNavigationItem];
    [self configTextView];
    
    if (!self.firstImage) {
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
        
        self.toPostImage = temp;
        
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
        
        self.toPostImage = temp;

        
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

-(void)configTextView{
    //textview;
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14.0];
    self.textView.textColor =[UIColor lightGrayColor];
    self.textView.text = @"请填写内容...";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    
    
    
    
    [self.view addSubview:self.textView];
    
    
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(@200);
    }];
    
    
    
}
#pragma mark -textView delegate

//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:@"请填写内容..."]) {
        textView.text = nil;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请填写内容...";
        textView.textColor = [UIColor lightGrayColor];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length > 255) {
        textView.text  =  [textView.text substringToIndex:255];
    }
    
    return YES;
}

#pragma mark - 发布
-(void)post:(id)sender{

    NSString *content;
    if ([self.textView.text isEqualToString:@""] ||[self.textView.text isEqualToString:@"请填写内容..."]) {
        content = nil;
    } else {
        content = self.textView.text;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.toPostImage];
    [SVProgressHUD showWithStatus:@"正在发布"];
    [NetworkManager publishTextContent:content withImages:array WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"status"] integerValue] == 2000) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kNeedSwitchToThree" object:nil];
            
            
        } else if([responseObject[@"status"] integerValue] == 1004){
            [SVProgressHUD showErrorWithStatus:@"服务器内部错误"];
        }else if ([responseObject[@"status"] integerValue] == 1012){
            
            [SVProgressHUD showErrorWithStatus:@"该账号已被锁定，请联系管理员"];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"发布失败,稍后再试吧"];
        }
        
    } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络出错"];
    }];
    

    
}


@end
