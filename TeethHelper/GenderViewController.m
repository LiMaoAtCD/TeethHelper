//
//  GenderViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "GenderViewController.h"

@interface GenderViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation GenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgView.alpha = 0.0;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 0.2;
    }];
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
- (IBAction)man:(id)sender {
    self.bgView.alpha = 0.0;
    if ([self.delegate respondsToSelector:@selector(didSelectGenderType:)]) {
        [self.delegate didSelectGenderType:MALE];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        

    }
}
- (IBAction)female:(id)sender {
    self.bgView.alpha = 0.0;

    if ([self.delegate respondsToSelector:@selector(didSelectGenderType:)]) {
        [self.delegate didSelectGenderType:FEMALE];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}
- (IBAction)cancel:(id)sender {
    self.bgView.alpha = 0.0;

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
