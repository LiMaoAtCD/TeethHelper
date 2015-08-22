//
//  ImageEditViewController.m
//  AVFoundationCamera
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 cmjstudio. All rights reserved.
//

#import "ImageEditViewController.h"
#import "Utils.h"
#import <Masonry.h>
#import "ImageCropperViewController.h"
@interface ImageEditViewController () <RSKImageCropViewControllerDataSource, RSKImageCropViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bottomBaseLabel;


@property (nonatomic, strong) ImageCropperViewController * cropperVC;
@end

@implementation ImageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.navigationController.navigationBar.translucent = NO;
//    self.imageView.image = self.sourceImage;
    self.cropperVC = [[ImageCropperViewController alloc] initWithImage:self.sourceImage cropMode:RSKImageCropModeCustom];
    self.cropperVC.delegate = self;
    
    
    [self addChildViewController:self.cropperVC];
    
    [self.cropperVC willMoveToParentViewController:self];
    [self.view addSubview:self.cropperVC.view];
    
    [self.cropperVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);

        make.bottom.equalTo(self.bottomBaseLabel.mas_top).offset(-20);

    }];
    
    [self.cropperVC didMoveToParentViewController:self];
    
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

#pragma mark - datasource

// Returns a custom rect for the mask.
- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    CGSize maskSize;
    if ([controller isPortraitInterfaceOrientation]) {
        maskSize = CGSizeMake(250, 250);
    } else {
        maskSize = CGSizeMake(220, 220);
    }
    maskSize = CGSizeMake(300, 150);
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    maskRect = CGRectMake(10, 100, 300, 100);
    
    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    CGRect rect = controller.maskRect;
    
    CGFloat radius = 50;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(radius, CGRectGetMinY(rect))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) -radius, CGRectGetMaxY(rect))];
    [path addLineToPoint:CGPointMake(radius, CGRectGetMaxY(rect))];
    
    [path addArcWithCenter:CGPointMake(radius, CGRectGetMinY(rect) + radius) radius:radius startAngle: 0.5 * M_PI endAngle:1.5 *M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect))];
    
    [path addArcWithCenter:CGPointMake(CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius) radius:radius startAngle: -0.5 * M_PI endAngle:0.5 *M_PI clockwise:YES];
    //    [path closePath];
    return path;
    
}

// Returns a custom rect in which the image can be moved.
- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller
{
    // If the image is not rotated, then the movement rect coincides with the mask rect.
    return controller.maskRect;
}


@end
