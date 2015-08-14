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
    
    
    if (self.type == Standard) {
        self.projectLabel.text = @"标准计划";
        self.timesLabel.text = @"4";
        self.perTimeMinutesLabel.text = @"32";
        self.projectDayLabel.text = @"5";
        [self.beginTimeButton setTitle:@"20:00" forState:UIControlStateNormal];
    } else if (self.type == Enhance){
        self.projectLabel.text = @"加强计划";
        self.timesLabel.text =@"7";
        self.perTimeMinutesLabel.text =@"56";
        self.projectDayLabel.text =@"3";
        [self.beginTimeButton setTitle:@"20:00" forState:UIControlStateNormal];
    } else{
        self.projectLabel.text = @"温柔计划";
        self.timesLabel.text =@"3";
        self.perTimeMinutesLabel.text =@"24";
        self.projectDayLabel.text =@"10";
        [self.beginTimeButton setTitle:@"20:00" forState:UIControlStateNormal];
    }
    
    
}

-(void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
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
