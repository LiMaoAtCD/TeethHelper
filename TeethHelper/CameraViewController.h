//
//  CameraViewController.h
//  AVFoundationCamera
//
//  Created by AlienLi on 15/8/14.
//  Copyright (c) 2015年 cmjstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoDelegate <NSObject>

-(void)getPhotoFromCamera:(UIImage *)image;

@end

@interface CameraViewController : UIViewController

@property (nonatomic,weak) id<PhotoDelegate> delegate;

@end
