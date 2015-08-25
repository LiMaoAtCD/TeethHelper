//
//  SocialDetailReplyViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/25.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialDetailReplyViewController.h"

@interface SocialDetailReplyViewController ()

@end

@implementation SocialDetailReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.likeView
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickForLike:)];
    
    [self.likeView addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comment:)];
    
    [self.replyView addGestureRecognizer:tap2];

}


-(void)clickForLike:(id)sender{
    
    if ([self.delegate respondsToSelector:@selector(didClickLike)]) {
        [self.delegate didClickLike];
   }
}

-(void)comment:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didCommentPressed)]) {
        [self.delegate didCommentPressed];
    }
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
