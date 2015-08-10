//
//  AvatarViewController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/10.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Camera,
    Album,
} PhotoType;

@protocol AvatarSelectionDelegate <NSObject>

-(void)didSelected:(PhotoType)type;

@end

@interface AvatarViewController : UIViewController



@end
