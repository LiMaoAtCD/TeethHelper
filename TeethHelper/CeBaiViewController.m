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
@interface CeBaiViewController ()<PhotoDelegate>

@end

@implementation CeBaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationItem.leftBarButtonItem = nil;

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

    [self showDetailViewController:cameraVC sender:self];
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
