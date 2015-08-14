//
//  QuestionAnalysizeController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionAnalysizeController.h"
#import "Utils.h"
#import <Masonry.h>

@interface QuestionAnalysizeController ()

@property (weak, nonatomic) IBOutlet UILabel *projectLabel;

@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UILabel *timesLabel;
@property (weak, nonatomic) IBOutlet UILabel *perTimeMinutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectDayLabel;

@property (weak, nonatomic) IBOutlet UIButton *beginTimeButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalMargin;



@end

@implementation QuestionAnalysizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白计划" onViewController:self];
    
    _verticalMargin.constant = 30;
//
//    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    
//    CGFloat marginHeight = height - 120  - 50;
//    
//    
//    CGFloat viewMargin =( marginHeight - 77 * 3 )/ 4;
//    
//    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(120 + viewMargin));
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.height.equalTo(@77);
//        
//    }];
//    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(120 + 2 * viewMargin + 77));
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.height.equalTo(@77);
//        
//    }];
//    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(120 + 3 * viewMargin));
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.height.equalTo(@77);
//        
//    }];
    
 
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

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
