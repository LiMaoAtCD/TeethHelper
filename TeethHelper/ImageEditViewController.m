//
//  ImageEditViewController.m
//  AVFoundationCamera
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 cmjstudio. All rights reserved.
//

#import "ImageEditViewController.h"
#import "Utils.h"
@interface ImageEditViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationController.navigationBar.translucent = NO;
    self.imageView.image = self.sourceImage;
    
}

-(void)pop{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
}
//-(void)viewWillDisappear:(BOOL)animated{
//    
//
//    [super viewWillDisappear:animated];
//}

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
