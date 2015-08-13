//
//  QuestionOneViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/13.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "QuestionOneViewController.h"
#import "Utils.h"
#import "QuestionOneView.h"
#import <Masonry.h>

@interface QuestionOneViewController ()

@property (nonatomic,strong) NSMutableArray *oneViewArrays;
@property (weak, nonatomic) IBOutlet UILabel *quesitonLabel;

@end

@implementation QuestionOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils ConfigNavigationBarWithTitle:@"问卷" onViewController:self];
    self.navigationItem.leftBarButtonItem = nil;

    NSArray *labels = @[@"20岁以下",@"20岁-25岁",@"25岁-30岁",@"30岁-35岁",@"35岁-40岁",@"40岁以上"];
    self.oneViewArrays = [NSMutableArray array];
    
    for (int i = 0 ; i < labels.count; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIndex:)];
        QuestionOneView *view = [[QuestionOneView alloc] initWithLabel:labels[i]];
//        view.backgroundColor = [UIColor redColor];
        view.tag = i;
        [view addGestureRecognizer:tap];
        [self.view addSubview:view];
        [self.oneViewArrays addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(240 + i * 40);
            make.width.equalTo(@200);
            make.height.equalTo(@30);
            make.left.equalTo(self.view.mas_left).offset(50);
        }];
    }
    
    [self.oneViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == 0) {
            [view didSelectionAtIndex:Selected];
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
    
}

-(void)selectIndex:(UITapGestureRecognizer *)tap{
    [self.oneViewArrays enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        QuestionOneView *view = obj;
        if (idx == tap.view.tag) {
            [view didSelectionAtIndex:Selected];
        } else{
            [view didSelectionAtIndex:Normal];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


@end
