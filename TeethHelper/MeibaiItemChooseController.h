//
//  MeibaiItemChooseController.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/16.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    Times,
    Days,
} ItemType;
@protocol ItemChooseDelegate <NSObject>

-(void)didSelectedIndexAt:(NSInteger)index OnType:(ItemType)type;

@end


@interface MeibaiItemChooseController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, assign) ItemType type;
@property(nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<ItemChooseDelegate> delegate;


@end
