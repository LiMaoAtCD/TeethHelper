//
//  BirthDayViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "BirthDayViewController.h"

@interface BirthDayViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) NSDate *birthday;
@end

@implementation BirthDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgView.alpha = 0.0;
    
    [_datePicker addTarget:self action:@selector(datePick:) forControlEvents:UIControlEventValueChanged];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
//    self.birthday = [formatter stringFromDate:[NSDate date]];
    self.birthday = [NSDate date];
}
-(void)datePick:(UIDatePicker *)picker{
//    self.birthday = [picker date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
//    self.birthday = [formatter stringFromDate:picker.date];
    self.birthday = picker.date;
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
- (IBAction)sure:(id)sender {
    self.bgView.alpha = 0.0;
    if ([self.delegate respondsToSelector:@selector(didSelectedBirthDay:)]) {
        [self.delegate didSelectedBirthDay:self.birthday];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (IBAction)cancel:(id)sender {
    self.bgView.alpha = 0.0;
    [self dismissViewControllerAnimated:YES completion:nil];
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
