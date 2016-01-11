//
//  CeBaiAlertController.h
//  TeethHelper
//
//  Created by AlienLi on 16/1/11.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertSelectionDelegate <NSObject>

-(void)didSelectedCancel:(BOOL)cancel;

@end
@interface CeBaiAlertController : UIViewController

@property (weak, nonatomic) id<AlertSelectionDelegate> delegate;

@end
