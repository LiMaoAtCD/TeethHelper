//
//  CameraViewController.m
//  AVFoundationCamera
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 cmjstudio. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageEditViewController.h"
#import "ImageCropperViewController.h"

#import <Masonry.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface CameraViewController () <RSKImageCropViewControllerDataSource, RSKImageCropViewControllerDelegate>

//@interface CameraViewController ()<RSKImageCropViewControllerDataSource>

@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设置之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;//照片输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIButton *takeButton;//拍照按钮
@property (weak, nonatomic) IBOutlet UIImageView *focusCursor; //聚焦光标
@property (weak, nonatomic) IBOutlet UILabel *teethLabel;

@property (weak, nonatomic) IBOutlet UIButton *flashButton;

@end

@implementation CameraViewController
#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;

    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    [super viewWillAppear:animated];
//    [self.view layoutIfNeeded];
    
    
    
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetPhoto]) {//设置分辨率
        _captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    }
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        NSLog(@"取得前置摄像头时出现问题.");
        ImageCropperViewController *cropper  =[[ImageCropperViewController alloc] initWithImage:[UIImage imageNamed:@"splash_1"] cropMode:RSKImageCropModeCustom];
        cropper.dataSource = self;
        cropper.avoidEmptySpaceAroundImage = YES;
        [self.navigationController pushViewController:cropper animated:YES];
        
        return;
    }
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    //初始化设备输出对象，用于获得输出数据
    _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
        [_captureSession addOutput:_captureStillImageOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer= self.viewContainer.layer;
    layer.masksToBounds=YES;
    
//    _captureVideoPreviewLayer.frame=CGRectMake(layer.bounds.origin.x, layer.bounds.origin.y, layer.bounds.size.width, layer.bounds.size.height + 20);
    _captureVideoPreviewLayer.frame=self.view.bounds;

    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    _captureVideoPreviewLayer.frame= CGRectMake(0, 0, width, height - 150);
    [_captureVideoPreviewLayer metadataOutputRectOfInterestForRect:layer.bounds];
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    [_captureVideoPreviewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    //将视频预览层添加到界面中
//    [layer addSublayer:_captureVideoPreviewLayer];
    [layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];
    
    [self addNotificationToCaptureDevice:captureDevice];
//    [self addGenstureRecognizer];
    [self setFlashModeButtonStatus];
    
    //先隐藏视图
//    self.view.alpha = 0.0;
    
    
    UIImageView *areaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"area"]];
    
    [self.viewContainer addSubview:areaImageView];
    
    
    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        
        [areaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewContainer.mas_top).offset(150);
            make.centerX.equalTo(_viewContainer.mas_centerX);
            make.height.equalTo(@128);
            make.width.equalTo(@240);

        }];
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        
        [areaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewContainer.mas_top).offset(170);
            make.centerX.equalTo(_viewContainer.mas_centerX);
            make.height.equalTo(@128);
            make.width.equalTo(@240);
            
        }];

    } else if ([UIScreen mainScreen].bounds.size.width > 375){
        
        [areaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewContainer.mas_top).offset(220);
            make.centerX.equalTo(_viewContainer.mas_centerX);
            make.height.equalTo(@128);
            make.width.equalTo(@240);
            
        }];
    }
   

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.captureSession startRunning];

    
    //牙齿提示语消失
    [UIView animateWithDuration:1.0 delay:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.teethLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];

}

-(void)dealloc{
    [self removeNotification];
}
#pragma mark - UI方法
#pragma mark 拍照
- (IBAction)takeButtonClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewContainer.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.viewContainer.alpha = 1.0;
        }
    }];
    
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection=[self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    [captureConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];

    [captureConnection setVideoScaleAndCropFactor:1.0];
    

    //根据连接取得设备输出的数据
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            
            //停止捕捉
            [self.captureVideoPreviewLayer removeFromSuperlayer];
            self.captureVideoPreviewLayer = nil;
            
            [self.captureSession stopRunning];

            //获取数据
            NSData *imageData=[AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image=[UIImage imageWithData:imageData];
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

//            CGRect rect = CGRectMake(0,
//                                     0,
//                                     640 * 2,
//                                     480 * 2);
            
//            CGRect rect = CGRectMake(0,
//                                     0,
//                                     640 * 2,
//                                     480 * 2);
//            
//            CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
//            UIImage *result = [UIImage imageWithCGImage:imageRef
//                                                  scale:2.0
//                                            orientation:UIImageOrientationRight];
//            CGImageRelease(imageRef);
            
            
//
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            
//            ImageEditViewController *editorVC = [sb instantiateViewControllerWithIdentifier:@"ImageEditViewController"];
//            
//            editorVC.sourceImage  = image;
//            [self.navigationController pushViewController:editorVC animated:YES];

            ImageCropperViewController *cropper  =[[ImageCropperViewController alloc] initWithImage:image cropMode:RSKImageCropModeCustom];
            cropper.dataSource = self;
            [self.navigationController pushViewController:cropper animated:YES];
            
        }
        
    }];
}

- (IBAction)dismiss:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 切换前后摄像头
- (IBAction)toggleButtonClick:(UIButton *)sender {
    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition=[currentDevice position];
    [self removeNotificationFromCaptureDevice:currentDevice];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront) {
        toChangePosition=AVCaptureDevicePositionBack;
    }
    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput=toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];
    
    [self setFlashModeButtonStatus];
}

//#pragma mark 自动闪光灯开启
//- (IBAction)flashAutoClick:(UIButton *)sender {
//    [self setFlashMode:AVCaptureFlashModeAuto];
//    [self setFlashModeButtonStatus];
//}
//#pragma mark 打开闪光灯
//- (IBAction)flashOnClick:(UIButton *)sender {
//    [self setFlashMode:AVCaptureFlashModeOn];
//    [self setFlashModeButtonStatus];
//}
//#pragma mark 关闭闪光灯
//- (IBAction)flashOffClick:(UIButton *)sender {
//    [self setFlashMode:AVCaptureFlashModeOff];
//    [self setFlashModeButtonStatus];
//}
- (IBAction)flashModeChangeClick:(id)sender {
    
    AVCaptureDevice *captureDevice=[self.captureDeviceInput device];
    AVCaptureFlashMode flashMode=captureDevice.flashMode;
    
    switch (flashMode) {
        case AVCaptureFlashModeOn:
            [self setFlashMode:AVCaptureFlashModeOff];
            [self.flashButton setImage:[UIImage imageNamed:@"btn_flashon_normal"] forState:UIControlStateNormal];
            break;
        case AVCaptureFlashModeOff:{
            [self setFlashMode:AVCaptureFlashModeOn];
            [self.flashButton setImage:[UIImage imageNamed:@"btn_flashoff_normal"] forState:UIControlStateNormal];

        }
            break;
        default:{
            [self.flashButton setImage:[UIImage imageNamed:@"btn_flashon_normal"] forState:UIControlStateNormal];

            [self setFlashMode:AVCaptureFlashModeOff];

        }
            break;
    }
    
}

#pragma mark - 通知
/**
 *  给输入设备添加通知
 */
-(void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice{
    //注意添加区域改变捕获通知必须首先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled=YES;
    }];
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //捕获区域发生改变
    [notificationCenter addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
-(void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
/**
 *  移除所有通知
 */
-(void)removeNotification{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

-(void)addNotificationToCaptureSession:(AVCaptureSession *)captureSession{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //会话出错
    [notificationCenter addObserver:self selector:@selector(sessionRuntimeError:) name:AVCaptureSessionRuntimeErrorNotification object:captureSession];
}

/**
 *  设备连接成功
 *
 *  @param notification 通知对象
 */
-(void)deviceConnected:(NSNotification *)notification{
    NSLog(@"设备已连接...");
}
/**
 *  设备连接断开
 *
 *  @param notification 通知对象
 */
-(void)deviceDisconnected:(NSNotification *)notification{
    NSLog(@"设备已断开.");
}
/**
 *  捕获区域改变
 *
 *  @param notification 通知对象
 */
-(void)areaChange:(NSNotification *)notification{
    NSLog(@"捕获区域改变...");
}

/**
 *  会话出错
 *
 *  @param notification 通知对象
 */
-(void)sessionRuntimeError:(NSNotification *)notification{
    NSLog(@"会话发生错误.");
}

#pragma mark - 私有方法

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

/**
 *  设置闪光灯模式
 *
 *  @param flashMode 闪光灯模式
 */
-(void)setFlashMode:(AVCaptureFlashMode )flashMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFlashModeSupported:flashMode]) {
            [captureDevice setFlashMode:flashMode];
        }
    }];
}
/**
 *  设置聚焦模式
 *
 *  @param focusMode 聚焦模式
 */
-(void)setFocusMode:(AVCaptureFocusMode )focusMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}
/**
 *  设置曝光模式
 *
 *  @param exposureMode 曝光模式
 */
-(void)setExposureMode:(AVCaptureExposureMode)exposureMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
    }];
}
/**
 *  设置聚焦点
 *
 *  @param point 聚焦点
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}

/**
 *  添加点按手势，点按时聚焦
 */
//-(void)addGenstureRecognizer{
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
//    [self.viewContainer addGestureRecognizer:tapGesture];
//}
//-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
//    CGPoint point= [tapGesture locationInView:self.viewContainer];
//    //将UI坐标转化为摄像头坐标
//    CGPoint cameraPoint= [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
//    [self setFocusCursorWithPoint:point];
//    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
//}

/**
 *  设置闪光灯按钮状态
 */
-(void)setFlashModeButtonStatus{
    AVCaptureDevice *captureDevice=[self.captureDeviceInput device];
//    AVCaptureFlashMode flashMode=captureDevice.flashMode;
    if([captureDevice isFlashAvailable]){
        self.flashButton.hidden = NO;

//        self.flashAutoButton.hidden=NO;
//        self.flashOnButton.hidden=NO;
//        self.flashOffButton.hidden=NO;
//        self.flashAutoButton.enabled=YES;
//        self.flashOnButton.enabled=YES;
//        self.flashOffButton.enabled=YES;
//        switch (flashMode) {
//            case AVCaptureFlashModeAuto:
//                self.flashAutoButton.enabled=NO;
//                break;
//            case AVCaptureFlashModeOn:
//                self.flashOnButton.enabled=NO;
//                break;
//            case AVCaptureFlashModeOff:
//                self.flashOffButton.enabled=NO;
//                break;
//            default:
//                break;
//        }
    }else{
//        self.flashAutoButton.hidden=YES;
//        self.flashOnButton.hidden=YES;
//        self.flashOffButton.hidden=YES;
        self.flashButton.hidden = YES;
    }
}

/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
//-(void)setFocusCursorWithPoint:(CGPoint)point{
//    self.focusCursor.center=point;
//    self.focusCursor.transform=CGAffineTransformMakeScale(1.5, 1.5);
//    self.focusCursor.alpha=1.0;
//    [UIView animateWithDuration:1.0 animations:^{
//        self.focusCursor.transform=CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        self.focusCursor.alpha=0;
//        
//    }];
//}

#pragma mark - datasource

// Returns a custom rect for the mask.
- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    CGSize maskSize;
    if ([controller isPortraitInterfaceOrientation]) {
        maskSize = CGSizeMake(250, 250);
    } else {
        maskSize = CGSizeMake(220, 220);
    }
    maskSize = CGSizeMake(300, 150);
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    
    maskRect = CGRectMake(0, 150, width, 100);
    

    
//    if ([UIScreen mainScreen].bounds.size.width == 320) {
//        maskRect = CGRectMake(0, 50, width, 100);
//    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
//
//        maskRect = CGRectMake(0, 150, width, 100);
//    } else if ([UIScreen mainScreen].bounds.size.width > 375){
//
//        maskRect = CGRectMake(0, 300, width, 100);
//    }

    
    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{

    
    CGRect rect = controller.maskRect;
    CGFloat radius = 50;
    
    CGRect temp;
    
//    if ([UIScreen mainScreen].bounds.size.width == 320) {
//        temp = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
//        
//        temp = CGRectMake(rect.origin.x, rect.origin.y - 60, rect.size.width, rect.size.height);
//    } else if ([UIScreen mainScreen].bounds.size.width > 375){
//        
//        temp = CGRectMake(rect.origin.x, rect.origin.y - 150, rect.size.width, rect.size.height);
//    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 40 , 0 )
                                                    cornerRadius:radius];
    
    return path;
    
}

// Returns a custom rect in which the image can be moved.
- (CGRect)imageCropViewControllerCustomMovementRect:(RSKImageCropViewController *)controller
{
    // If the image is not rotated, then the movement rect coincides with the mask rect.
//    return controller.maskRect;
    
//    
//    if ([UIScreen mainScreen].bounds.size.width == 320) {
//        return controller.maskRect;
//    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
//      
//        return  CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 100);
//
//    } else if ([UIScreen mainScreen].bounds.size.width > 375){
//        
//        return  CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 100);
//    }
    
    

    
    return  controller.maskRect;
}




@end
