//
//  PostTopicViewController.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/23.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "PostTopicViewController.h"
#import "Utils.h"
#import <Masonry.h>
#import "AvatarViewController.h"

#import "NetworkManager.h"
#import <SVProgressHUD.h>
@interface PostTopicViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,AvatarSelectionDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) UIButton *imageButton1;
@property (nonatomic, strong) UIButton *imageButton2;
@property (nonatomic, strong) UIButton *imageButton3;

@property (nonatomic, strong) UIImage *toPostImage1;
@property (nonatomic, strong) UIImage *toPostImage2;
@property (nonatomic, strong) UIImage *toPostImage3;


@property (nonatomic, strong) UIImagePickerController *picker;

@property (nonatomic, assign) NSInteger currentButtonTag;




@end

@implementation PostTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utils ConfigNavigationBarWithTitle:@"发帖" onViewController:self];
    UIButton *publish = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40,21)];
    [publish setAttributedTitle:[[NSAttributedString alloc] initWithString:@"提交" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:    [UIFont systemFontOfSize:13.0]}] forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(postTopic:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:publish];
    
    
    [self configTextView];
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.allowsEditing = YES;
    self.picker.delegate = self;
    
    
    
    
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

-(void)configTextView{
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:14.0];
    self.textView.textColor =[UIColor lightGrayColor];
    self.textView.text = @"请填写内容...";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    


    
    [self.view addSubview:self.textView];
    
    
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    
    
    
    
    
    self.lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    
    [self.view addSubview:self.lineImageView];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom);
        make.left.equalTo(self.textView.mas_left);
        make.right.equalTo(self.textView.mas_right);
        make.height.equalTo(@1);

    }];
    
    self.imageButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton1 setImage:[UIImage imageNamed:@"social_imageupload_normal"] forState:UIControlStateNormal];
    self.imageButton1.tag = 1;

    [self.imageButton1 addTarget:self action:@selector(chooseImageForPost:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageButton1];
    
    
    [self.imageButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.width.equalTo(@72);
        make.height.equalTo(@72);
    }];
    
    
    self.imageButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton2 setImage:[UIImage imageNamed:@"social_imageupload_normal"] forState:UIControlStateNormal];
    self.imageButton2.tag = 2;

    self.imageButton2.hidden = YES;
    [self.imageButton2 addTarget:self action:@selector(chooseImageForPost:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.imageButton2];
    
    [self.imageButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(20);
        make.left.equalTo(self.imageButton1.mas_right).offset(10);
        make.width.equalTo(@72);
        make.height.equalTo(@72);
    }];

    
    self.imageButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton3.tag = 3;
    [self.imageButton3 setImage:[UIImage imageNamed:@"social_imageupload_normal"] forState:UIControlStateNormal];
    self.imageButton3.hidden = YES;
    [self.imageButton3 addTarget:self action:@selector(chooseImageForPost:) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:self.imageButton3];
    
    [self.imageButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(20);
        make.left.equalTo(self.imageButton2.mas_right).offset(10);
        make.width.equalTo(@72);
        make.height.equalTo(@72);
    }];

    
    
    
    
}


-(void)chooseImageForPost:(UIButton*)button{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    AvatarViewController *avatar = [sb instantiateViewControllerWithIdentifier:@"AvatarViewController"];
    avatar.delegate = self;
    [self showDetailViewController:avatar sender:self];
    
    if (button.tag == 1) {
        self.currentButtonTag = 1;
    
    } else if (button.tag == 2){
        self.currentButtonTag = 2;

    } else{
        self.currentButtonTag = 3;

    }
}

-(void)didSelectedPhoto:(PhotoType)type{
    
    if (type == Camera) {
        //调用系统相机
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] ) {
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    } else {
        //调用相册
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self showDetailViewController:_picker sender:self];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *tempImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    switch (self.currentButtonTag) {
        case 1:
        {
            [self.imageButton1 setImage:tempImage forState:UIControlStateNormal];
            self.imageButton2.hidden = NO;
            self.imageButton3.hidden = YES;
            self.toPostImage1 = tempImage;
        }
            break;
        case 2:
        {
            [self.imageButton2 setImage:tempImage forState:UIControlStateNormal];
            self.imageButton3.hidden = NO;
            self.toPostImage2 = tempImage;


        }
            break;
        case 3:
        {
            [self.imageButton3 setImage:tempImage forState:UIControlStateNormal];
            self.toPostImage3 = tempImage;

        }
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];

    
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length > 255) {
        textView.text  =  [textView.text substringToIndex:255];
    }
    
    return YES;
}

#pragma mark - 发布

-(void)postTopic:(id)sender{
    
    if ([self.textView.text isEqualToString:@""] ||[self.textView.text isEqualToString:@"请填写内容..."] ) {
        //没有填写内容
        if (self.toPostImage1 == nil&&self.toPostImage2 == nil&&self.toPostImage3 == nil) {
            //提示需要填写内容
            [SVProgressHUD showErrorWithStatus:@"您还没有填写内容或选择图片"];
            
        } else{
            //只发布图片
            //图片+ 文字
            NSMutableArray *array = [NSMutableArray array];
            if (self.toPostImage1) {
                [array addObject:self.toPostImage1];
            }
            if (self.toPostImage2) {
                [array addObject:self.toPostImage2];
            }
            if (self.toPostImage3) {
                [array addObject:self.toPostImage3];
            }
            
            [SVProgressHUD showWithStatus:@"正在发布"];

            [NetworkManager publishTextContent:nil withImages:array WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@",responseObject);
                if ([responseObject[@"status"] integerValue] == 2000) {
                    [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else if([responseObject[@"status"] integerValue] == 1004){
                    [SVProgressHUD showErrorWithStatus:@"服务器内部错误"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"发布失败,稍后再试吧"];
                }

            } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络出错"];
            }];
        }
    } else{
        //填写内容
        if (self.toPostImage1 == nil&&self.toPostImage2 == nil&&self.toPostImage3 == nil) {
            //只发布文字
            [SVProgressHUD showWithStatus:@"正在发布"];
            [NetworkManager publishTextContent:self.textView.text WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject[@"status"] integerValue] == 2000) {
                    [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else if([responseObject[@"status"] integerValue] == 1004){
                    [SVProgressHUD showErrorWithStatus:@"服务器内部错误"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"发布失败,稍后再试吧"];
                }
                
            } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络出错了"];
            }];
            
        } else{
            
            //图片+ 文字
            NSMutableArray *array = [NSMutableArray array];
            if (self.toPostImage1) {
                [array addObject:self.toPostImage1];
            }
            if (self.toPostImage2) {
                [array addObject:self.toPostImage2];
            }
            if (self.toPostImage3) {
                [array addObject:self.toPostImage3];
            }
            [SVProgressHUD showWithStatus:@"正在发布"];
            [NetworkManager publishTextContent:self.textView.text withImages:array WithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject[@"status"] integerValue] == 2000) {
                    [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else if([responseObject[@"status"] integerValue] == 1004){
                    [SVProgressHUD showErrorWithStatus:@"服务器内部错误"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"发布失败,稍后再试吧"];
                }
                
            } FailHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"网络出错"];
            }];
        }
    }
}

@end
