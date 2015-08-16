//
//  MeibaiItemChooseController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/16.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "MeibaiItemChooseController.h"

@interface MeibaiItemChooseController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *itemPicker;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, assign) NSInteger currentIndex;


@end

@implementation MeibaiItemChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgView.alpha = 0.0;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.itemPicker.dataSource = self;
    self.itemPicker.delegate = self;

    
    
    
    if (_type == Times) {
        self.titleLabel.text = @"美白时长";
        

    }else{
        self.titleLabel.text = @"美白天数";

    }
    
    self.currentIndex = 0;
    
    
    
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
- (IBAction)cancel:(id)sender {
    self.bgView.alpha = 0.0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sure:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didSelectedIndexAt:OnType:)]) {
        [self.delegate didSelectedIndexAt:self.currentIndex OnType:_type];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.items.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.items[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"row: %ld",row);
    self.currentIndex = row;
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
