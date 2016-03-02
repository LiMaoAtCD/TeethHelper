//
//  CeBaiViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "CeBaiViewController.h"
#import "CameraViewController.h"
#import "ImageEditViewController.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "SecondHelpViewController.h"

@interface CeBaiViewController ()<PhotoDelegate>


@property (nonatomic, assign) BOOL needSwitchToOne;
@property (nonatomic, assign) BOOL needSwitchToThree;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation CeBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationItem.leftBarButtonItem = nil;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needSwitchToOneMethod) name:@"kNeedSwitchToOne" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kNeedSwitchToThree) name:@"kNeedSwitchToThree" object:nil];
    
    UIButton *rightHelpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightHelpButton setTitle:@"帮助" forState:UIControlStateNormal];
    
    [rightHelpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    rightHelpButton.frame = CGRectMake(0, 0, 60, 35);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightHelpButton];

    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        
        
        self.imageview.image = [UIImage imageNamed:@"cebai_5"];
        self.imageview.frame = CGRectMake(0, 0, 320, 820.0 / 2);
        
        
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        
        self.imageview.image = [UIImage imageNamed:@"cebai_6"];
        self.imageview.frame = CGRectMake(0, 0, 375, 1018.0 / 2);
    } else {
        
        
        self.imageview.image = [UIImage imageNamed:@"cebai_7"];
        self.imageview.frame = CGRectMake(0, 0, 1242. / 3, 1734.0 / 3);
        
        
    }
    
}

-(void)help{
    SecondHelpViewController *second = [[SecondHelpViewController alloc] initWithNibName:@"SecondHelpViewController" bundle:nil];
    second.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:second animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)needSwitchToOneMethod{
    
    _needSwitchToOne = YES;
}

-(void)kNeedSwitchToThree{
    _needSwitchToThree = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    MainTabBarController * vc = (MainTabBarController *)delegate.window.rootViewController;
    
    if (_needSwitchToOne) {
    
        vc.selectedIndex = 0;
        
        _needSwitchToOne = NO;
    }
    
    if (_needSwitchToThree) {
        vc.selectedIndex = 2;

        _needSwitchToThree = NO;
    }
    
   
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
- (IBAction)beginCeBai:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController *cameraVC = [sb instantiateViewControllerWithIdentifier:@"CameraViewController"];
    cameraVC.delegate = self;
    cameraVC.hidesBottomBarWhenPushed = YES;
//    [self showDetailViewController:cameraVC sender:self];
    [self.navigationController pushViewController:cameraVC animated:YES];
}

-(void)getPhotoFromCamera:(UIImage *)image{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImageEditViewController *editorVC = [sb instantiateViewControllerWithIdentifier:@"ImageEditViewController"];
    
    editorVC.sourceImage  = image;
    editorVC.hidesBottomBarWhenPushed = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:editorVC animated:YES];
        
    });
    
}

@end
