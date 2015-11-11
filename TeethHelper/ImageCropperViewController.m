//
//  ImageCropperViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/22.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ImageCropperViewController.h"
#import "Utils.h"
#import <Masonry.h>
#import "CeBaiResultViewController.h"
@interface ImageCropperViewController ()<RSKImageCropViewControllerDelegate>

@end

@implementation ImageCropperViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utils ConfigNavigationBarWithTitle:@"测白" onViewController:self];
    self.delegate = self;
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    UIView *result = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 320, 68)];
    result.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:result];
    
    self.cancelButton.hidden= YES;
//    self.chooseButton.hidden = YES;
    self.moveAndScaleLabel.hidden = YES;
    
    
    [result mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@150);

    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label1.text =@"小贴士:请确保开口器在椭圆区域内";
    
    
    [result addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(result).offset(20);
        make.right.equalTo(result).offset(-20);
        make.height.equalTo(@20);
//        make.centerY.equalTo(result.mas_centerY).offset(0);
        make.top.equalTo(result).offset(8);

    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.text =@"如果部分超出，请调整至椭圆区域内";

    [result addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(result).offset(20);
        make.right.equalTo(result).offset(-20);
        make.height.equalTo(@20);
        make.top.equalTo(label1).offset(30);
        
    }];

    
    UIButton *showResultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [showResultButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"看结果" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0]}] forState:UIControlStateNormal];
    [showResultButton setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [showResultButton addTarget:self action:@selector(clickShowResult:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [result addSubview:showResultButton];
    [showResultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(result).offset(20);
        make.right.equalTo(result).offset(-20);
        make.height.equalTo(@50);
        make.bottom.equalTo(result).offset(-15);
        
    }];
    [result addSubview:self.chooseButton];
    [self.chooseButton setTitle:@"" forState:UIControlStateNormal];
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(result).offset(20);
        make.right.equalTo(result).offset(-20);
        make.height.equalTo(@50);
        make.bottom.equalTo(result).offset(-15);
        
    }];
}

-(void)clickShowResult:(UIButton*)button{
    
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
//    [self.addPhotoButton setImage:croppedImage forState:UIControlStateNormal];
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    CeBaiResultViewController *resultVC = [[CeBaiResultViewController alloc] initWithNibName:@"CeBaiResultViewController" bundle:nil];
    resultVC.imageForTesting= croppedImage;
//    resultVC.imageForDisplay = image2;

    [self.navigationController pushViewController:resultVC animated:YES];
    
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage CropedImage2:(UIImage*)image2 usingCropRect:(CGRect)cropRect{
    
    CeBaiResultViewController *resultVC = [[CeBaiResultViewController alloc] initWithNibName:@"CeBaiResultViewController" bundle:nil];
    resultVC.imageForTesting= croppedImage;
    resultVC.imageForDisplay = image2;
    [self.navigationController pushViewController:resultVC animated:YES];

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
