//
//  GLDPopPicker.h
//  GLDPicker
//
//  Created by Jone on 15/6/23.
//  Copyright (c) 2015年 HangZhou DeLan Technology Co. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, GLDPopPickerType) {
    GLDPopPickerTypeDefault = 0,   // picer view with no data,
    GLDPopPickerTypeAddress,       // address picker view
    GLDPopPickerTypeTime,          // date picker view
};

@interface ChinaAddressModel : NSObject

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;

@end


@class GLDPopPicker;
@protocol GLDPopPickerDataSouce <NSObject>

@optional

- (NSInteger)numberOfComponentsInPickerView:(GLDPopPicker *)popPicker;
- (NSInteger)popPicker:(GLDPopPicker *)popPicker numberOfRowsInComponent:(NSInteger)component;

@end



@protocol GLDPopPickerDelegate <NSObject>

@optional

// returns width of column and height of row for each component.
- (CGFloat)popPicker:(GLDPopPicker *)popPicker widthForComponent:(NSInteger)component;
- (CGFloat)popPicker:(GLDPopPicker *)popPicker rowHeightForComponent:(NSInteger)component;
- (UIView *)popPicker:(GLDPopPicker *)popPicker viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)popPicker:(GLDPopPicker *)popPicker didSelectedAddress:(ChinaAddressModel *)address;
- (void)popPicker:(GLDPopPicker *)popPicker didSelectedHour:(NSString *)hour mimute:(NSString *)minute;


// button action
- (void)cancelAction;
- (void)doneAction;

@end



@interface GLDPopPicker : UIView

@property (nonatomic, assign, readonly) BOOL isShow;           //  default is NO, picker view show

@property (nonatomic, assign) id <GLDPopPickerDataSouce> dataSource;
@property (nonatomic, assign) id <GLDPopPickerDelegate> delegate;

// used to set begin time, default is 00:00
@property (nonatomic, assign) NSInteger hour;    // hour from 0 to 23, otherwise equal 0
@property (nonatomic, assign) NSInteger minute;  // minute from 0 to 59, otherwise euqal 0

- (void)showDefaultPicker;   // show picker view with no content
- (void)showAddressPicker;   // show picker view with china address
- (void)showDatePicker;      // show picker view with time,format HH:mm

@end
