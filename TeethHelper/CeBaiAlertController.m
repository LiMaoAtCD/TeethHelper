//
//  CeBaiAlertController.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/11.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "CeBaiAlertController.h"

@interface CeBaiAlertController ()


@end

@implementation CeBaiAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clear:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedCancel:)]) {
        [self.delegate didSelectedCancel:NO];
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];

}

- (IBAction)dismissSelf:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedCancel:)]) {
        [self.delegate didSelectedCancel:YES];
    }
    [self dismissViewControllerAnimated:NO completion:nil];

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
