//
//  SocialCommentViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/25.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "SocialCommentViewController.h"
#import <Masonry.h>
@interface SocialCommentViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic , strong) UIView *commentView;

@property (nonatomic , strong) UITextView *textView;


@end


@implementation SocialCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor =[UIColor clearColor];
    
    self.bgView = [[UIView alloc] initWithFrame:self.view.frame];
    
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.0;
    
    [self.view addSubview:self.bgView];
    
    
    self.commentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.commentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.view addSubview:self.commentView];

    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text =@"回复";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font =[UIFont systemFontOfSize:18.0];
    [self.commentView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.centerX.equalTo(self.commentView.mas_centerX);
        make.height.equalTo(@30);
        make.top.equalTo(self.commentView.mas_top).offset(8);
    }];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancel setImage:[UIImage imageNamed:@"btn_close_pressed"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelComment:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentView addSubview:cancel];
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentView.mas_left).offset(8);
        make.top.equalTo(self.commentView.mas_top).offset(8);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAttributedTitle:[[NSAttributedString alloc] initWithString:@"提交" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]}] forState:UIControlStateNormal];
    [send setBackgroundImage:[UIImage imageNamed:@"bg_green"] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentView addSubview:send];
    
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentView.mas_right).offset(-8);
        make.top.equalTo(self.commentView.mas_top).offset(8);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14.0];
    self.textView.textColor =[UIColor lightGrayColor];
    self.textView.text = @"请填写内容...";

    
    [self.commentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentView).offset(8);
        make.right.equalTo(self.commentView).offset(-8);
        make.top.equalTo(label.mas_bottom).offset(8);
        make.bottom.equalTo(self.commentView).offset(-8);

    }];
    
    [self registerForKeyboardNotifications];
    [self.textView becomeFirstResponder];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 0.2;

    } completion:^(BOOL finished) {
    }];
}



- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark - 键盘相关处理
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self.commentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(@(-kbSize.height));
        make.height.equalTo(@200);
    }];
    
    
 }

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.commentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(@0);
        make.height.equalTo(@200);
    }];
}

#pragma mark -textView delegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:@"请填写内容..."]) {
        textView.text = nil;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请填写内容...";
        textView.textColor = [UIColor lightGrayColor];
    }
}


-(void)textViewDidChange:(UITextView *)textView{
    NSInteger number = [textView.text length];
    if (number > 255) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于255" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:253];
        number = 253;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelComment:(id)sender{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendComment:(id)sender{
    if (self.textView.text.length > 0 ) {
        if ([self.delegate respondsToSelector:@selector(postComment:)]) {
            [self.delegate postComment:self.textView.text];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"回复不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
   

}

@end
