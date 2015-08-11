//
//  MessageTimeChooseController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/11.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MessageTimeChooseController.h"

@interface MessageTimeChooseController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;


@end

@implementation MessageTimeChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backgroundView.alpha = 0.0;
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.1 animations:^{
        _backgroundView.alpha = 0.2;

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
- (IBAction)cancel:(id)sender {
    self.backgroundView.alpha = 0.0;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)sure:(id)sender {
    self.backgroundView.alpha = 0.0;
    
    if ([self.delegate respondsToSelector:@selector(didSelectTime:)]) {
        [self.delegate didSelectTime:_timePicker.date];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
