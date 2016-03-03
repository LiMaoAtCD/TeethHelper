//
//  LoginPreviseViewController.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/6.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "LoginPreviseViewController.h"
#import "SplashViewController.h"
@interface LoginPreviseViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) SplashViewController *splashVC;
@end

@implementation LoginPreviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"_first_launch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"_first_launch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [self addSplashView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([UIScreen mainScreen].bounds.size.width == 320) {
                
                
                self.imageView.image = [UIImage imageNamed:@"login_5"];
                self.imageView.frame = CGRectMake(0, 0, 320, 864.0 / 2);
                
                
            } else if ([UIScreen mainScreen].bounds.size.width == 375) {
                
                self.imageView.image = [UIImage imageNamed:@"login_6"];
                self.imageView.frame = CGRectMake(0, 0, 375, 1062.0 / 2);
            } else {
                
                
                self.imageView.image = [UIImage imageNamed:@"login_7"];
                self.imageView.frame = CGRectMake(0, 0, 1242. / 3, 1800.0 / 3);
            }
            
        });
    }
    
        if ([UIScreen mainScreen].bounds.size.width == 320) {
            
            
            self.imageView.image = [UIImage imageNamed:@"login_5"];
            self.imageView.frame = CGRectMake(0, 0, 320, 864.0 / 2);
            
            
        } else if ([UIScreen mainScreen].bounds.size.width == 375) {
            
            self.imageView.image = [UIImage imageNamed:@"login_6"];
            self.imageView.frame = CGRectMake(0, 0, 375, 1062.0 / 2);
        } else {
            
            
            self.imageView.image = [UIImage imageNamed:@"login_7"];
            self.imageView.frame = CGRectMake(0, 0, 1242. / 3, 1800.0 / 3);
            
            
        }
        
    

    
    

    
    

}

-(void)addSplashView{
    [self presentViewController:self.splashVC animated:NO completion:^{
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];

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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
