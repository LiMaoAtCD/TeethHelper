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
#import "MessageTimeChooseController.h"
#import "MessageConfigureFile.h"
#import "MeiBaiConfigFile.h"

//#import "CeBaiViewController.h"
#import "FirstCeBaiViewController.h"
@interface QuestionAnalysizeController ()<TimeSelectionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *projectLabel;

@property (weak, nonatomic) IBOutlet UILabel *timesLabel;
@property (weak, nonatomic) IBOutlet UILabel *perTimeMinutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectDayLabel;

@property (weak, nonatomic) IBOutlet UIButton *beginTimeButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalMargin;


@property (weak, nonatomic) IBOutlet UILabel *changedLabel;

@end

@implementation QuestionAnalysizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白计划" onViewController:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
    if (self.type == Standard) {
        self.projectLabel.text = @"标准计划";
        self.timesLabel.text = @"4";
        self.perTimeMinutesLabel.text = @"32";
        self.projectDayLabel.text = @"5";
        [self.beginTimeButton setTitle:@"20:00" forState:UIControlStateNormal];
        self.changedLabel.text = @"根据您的情况，建议到个人中心适当增加每日次数（时间）";

        //设置美白等级为4
//        [MeiBaiConfigFile setCureTimesEachDay:4];
//        [MeiBaiConfigFile setNeedCureDays:5];
        [MeiBaiConfigFile setCurrentProject:STANDARD];

        
    } else if (self.type == Enhance){
        self.projectLabel.text = @"标准计划";
        self.timesLabel.text = @"4";
        self.perTimeMinutesLabel.text = @"32";
        self.projectDayLabel.text = @"5";
        self.changedLabel.text = @"建议到个人中心适当增加每日次数（时间）";

        [self.beginTimeButton setTitle:@"20:00" forState:UIControlStateNormal];
        
        //设置美白等级为7
//        [MeiBaiConfigFile setCureTimesEachDay:7];
//        [MeiBaiConfigFile setNeedCureDays:3];
        [MeiBaiConfigFile setCurrentProject:STANDARD];


    } else{
        self.projectLabel.text = @"标准计划";
        self.changedLabel.text = @"建议到个人中心减少每日次数（时间），同时可适当延长美白天数";

        self.timesLabel.text = @"4";
        self.perTimeMinutesLabel.text = @"32";
        self.projectDayLabel.text = @"5";
        [self.beginTimeButton setTitle:@"20:00" forState:UIControlStateNormal];
        
        //设置美白等级为3
//        [MeiBaiConfigFile setCureTimesEachDay:3];
//        [MeiBaiConfigFile setNeedCureDays:10];
        [MeiBaiConfigFile setCurrentProject:STANDARD];


    }

    [self.beginTimeButton addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)chooseTime:(id)sender{
    UIStoryboard *sb =[UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    MessageTimeChooseController *timeVC = [sb instantiateViewControllerWithIdentifier:@"MessageTimeChooseController"];
    
    timeVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    timeVC.delegate  = self;
    [self presentViewController:timeVC animated:YES completion:nil];
    
}

-(void)didSelectTime:(NSDate *)date{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *hour = [formatter stringFromDate:date];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"mm"];
    NSString *minute = [formatter1 stringFromDate:date];
    
    [MessageConfigureFile setAlertNotificationTime:hour andMinute:minute];
    [MessageConfigureFile setMeiBaiNotificationAtHour:hour minute:minute];
    
    NSString *time =[NSString stringWithFormat:@"%.2ld:%.2ld",(long)[hour integerValue],(long)[minute integerValue]];
    
    [self.beginTimeButton setTitle:time forState:UIControlStateNormal];

}


- (IBAction)gotoCeBai:(id)sender {
    
    
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"QuestionsCompleted" object:nil];
    
    
    FirstCeBaiViewController * first = [[FirstCeBaiViewController alloc] initWithNibName:@"FirstCeBaiViewController" bundle:nil];;
    
    [self.navigationController pushViewController:first animated:YES];
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    CeBaiViewController *cebai = [sb instantiateViewControllerWithIdentifier:@"CeBaiViewController"];
//    
//    [self.navigationController pushViewController:cebai animated:YES];
    

    
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
