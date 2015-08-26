//
//  ProtocolAgreementViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/26.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ProtocolAgreementViewController.h"

@interface ProtocolAgreementViewController ()


@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ProtocolAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"meiya_" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)unwind:(id)sender {
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
