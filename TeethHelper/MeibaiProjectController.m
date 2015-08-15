//
//  MeibaiProjectController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeibaiProjectController.h"
#import "Utils.h"

#import "AlienTimerView.h"

@interface MeibaiProjectController ()

@property (nonatomic, strong) AlienTimerView *alienView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation MeibaiProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"美白" onViewController:self];
    
    //分享
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"icon_share_normal"] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //圆形图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat CircleMargin = 70;
    self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
    if ([Utils isiPhone4]) {
        CGFloat CircleMargin = 90;
        self.alienView = [[AlienTimerView alloc] initWithFrame:CGRectMake(CircleMargin, 180, width - CircleMargin * 2, width - CircleMargin * 2)];
        self.alienView.timerLabel.font = [UIFont systemFontOfSize:80];
        
    }
    //    self.alienView = [[AlienView alloc] initWithFrame:CGRectMake(CircleMargin, 130, width - CircleMargin * 2, width - CircleMargin * 2)];
//    self.alienView.ti = @"10";
    
    [self.view addSubview:_alienView];
    
//    [self.alienView animateArcTo:0.7];
    
    self.totalCount = 0;
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)share:(UIButton*)button{
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
}

-(void)timerCount:(id)sender{
    self.totalCount++;
    
//    NSNumber *time = [NSNumber numberWithDouble:[self.totalCount - 3600];
//    NSTimeInterval interval = [time doubleValue];
//    NSDate *online = [NSDate date];
//    online = [NSDate dateWithTimeIntervalSince1970:interval];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"mm:ss"];
//    
//    NSLog(@"result: %@", [dateFormatter stringFromDate:online]);

//    NSNumber *theDouble = [NSNumber numberWithInt:self.totalCount];
//    
//    int inputSeconds = [theDouble intValue];
    int inputSeconds = (int)self.totalCount;
//    int hours =  inputSeconds / 3600;
    int minutes = inputSeconds / 60;
    int seconds = inputSeconds  - minutes * 60;
    
    NSString *theTime = [NSString stringWithFormat:@"%.2d'%.2d\"", minutes, seconds];
    NSLog(@"time %@",theTime);
    
    if (minutes == 99 && seconds == 59) {
        [self.timer invalidate];
    }
    
    self.alienView.timerLabel.text = theTime;
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
