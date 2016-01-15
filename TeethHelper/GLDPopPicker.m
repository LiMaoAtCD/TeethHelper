//
//  GLDPopPicker.m
//  GLDPicker
//
//  Created by Jone on 15/6/23.
//  Copyright (c) 2015年 HangZhou DeLan Technology Co. All rights reserved.
//

#import "GLDPopPicker.h"

static CGFloat GLDPopPickerHeightFactor = 0.5;
static CGFloat GLDPopPickerTitleViewHeight  = 50;
static CGFloat GLDPopPickerTitleLabelWidth = 200;
static CGFloat GLDPopPickerButtonWidth = 70;


#define UISCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define UISCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

typedef NS_ENUM(NSInteger, AddressType) {
    AddressTypeProvince = 0,
    AddressTypeCity     = 1,
    AddressTypeDistrict = 2
    
};


@implementation ChinaAddressModel

- (instancetype)init
{
    self = [super init];
    return self;
}

@end


@interface GLDPopPicker()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *doneButton;

// picker view
@property (nonatomic, strong) UIPickerView *defaultPickerView;
@property (nonatomic, strong) UIPickerView *addressPickerView;
@property (nonatomic, strong) UIPickerView *datePickerView;

// address Data
@property (nonatomic, strong) NSDictionary *addressDictionary;
@property (nonatomic, strong) NSString *currentProvince;
@property (nonatomic, strong) NSDictionary *currentDictionary;  // 当前选中的城市字典包含省市县
@property (strong, nonatomic) NSArray *province;  // 省
@property (strong, nonatomic) NSArray *city;      // 市
@property (strong, nonatomic) NSArray *district;  // 县


// Date data
@property (nonatomic, strong) NSMutableArray *hoursArray;
@property (nonatomic, strong) NSMutableArray *minutesArray;

@end


@implementation GLDPopPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT*GLDPopPickerHeightFactor);
        self.backgroundColor = [UIColor whiteColor];
        [self loadAddressMessage];  // 加载地址
        [self configureDate];       // 日期数据
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark -  Action

- (void)cancelButtonOnClick
{
    [self dismiss];
    if ([_delegate respondsToSelector:@selector(cancelAction)]) {
        [_delegate cancelAction];
    }
}

- (void)doneButtonOnClick
{
    [self dismiss];
    if ([_delegate respondsToSelector:@selector(doneAction)]) {
        [_delegate doneAction];
    }
}


#pragma mark - Private Method

- (void)drawRect:(CGRect)rect {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, GLDPopPickerTitleViewHeight)];
    titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - GLDPopPickerTitleLabelWidth / 2, 0, GLDPopPickerTitleLabelWidth, GLDPopPickerTitleViewHeight)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    titleLabel.font = font;
    titleLabel.textColor = [UIColor whiteColor];
    //[titleLabel sizeToFit];
    _titleLabel = titleLabel;
    _titleView = titleView;
    
    [titleView addSubview:_titleLabel];
    
    // cancel button
    CGFloat buttonOffset = 10.0f;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(buttonOffset, 0, GLDPopPickerButtonWidth, GLDPopPickerTitleViewHeight);
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1] forState:UIControlStateNormal];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.titleLabel.font = font;
    [leftButton addTarget:self action:@selector(cancelButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton = leftButton;
    [titleView addSubview:_cancelButton];
    
    // done button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(self.frame.size.width - GLDPopPickerButtonWidth - buttonOffset, 0, GLDPopPickerButtonWidth, GLDPopPickerTitleViewHeight);
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:10.0f/255.0f green:96.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.titleLabel.font = font;
    [rightButton addTarget:self action:@selector(doneButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    _doneButton = rightButton;
    [titleView addSubview:_doneButton];
    
    [self addSubview:_titleView];
    
    [self createPickerView];  // 创建picker view
    

}

- (void)createPickerView
{
    UIPickerView *nonePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, UISCREEN_WIDTH, GLDPopPickerHeightFactor*UISCREEN_HEIGHT)];
    nonePickerView.backgroundColor = [UIColor whiteColor];
    nonePickerView.delegate = self;
    nonePickerView.dataSource = self;
    nonePickerView.tag = 0;
    _defaultPickerView = nonePickerView;
    [self addSubview:nonePickerView];
  
    

    UIPickerView *addressPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, UISCREEN_WIDTH, GLDPopPickerHeightFactor*UISCREEN_HEIGHT)];
    addressPickerView.backgroundColor = [UIColor whiteColor];
    addressPickerView.delegate = self;
    addressPickerView.dataSource = self;
    addressPickerView.tag = 1;
    _addressPickerView = addressPickerView;
    [self addSubview:addressPickerView];
    
    
    UIPickerView *datePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, UISCREEN_WIDTH, GLDPopPickerHeightFactor*UISCREEN_HEIGHT)];
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    datePickerView.tag = 2;
    _datePickerView = datePickerView;
    [self addSubview:datePickerView];
}

// 加载地址信息
- (void)loadAddressMessage
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"chinaAddress" ofType:@"plist"];
    
    NSDictionary *addressDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _addressDictionary = addressDictionary;
    NSArray *components = [addressDictionary allKeys];
    
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[addressDictionary objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    _province = [[NSArray alloc] initWithArray:provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [_province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[addressDictionary objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    _city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [_city objectAtIndex: 0];
    _district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
//    _currentDictionary = @{@"gldprovince" : [_province firstObject], @"gldcity" : [_city firstObject], @"glddistrict" : [_district firstObject]};
    _currentDictionary = @{@"gldprovince" : [_province firstObject], @"gldcity" : [_city firstObject], @"glddistrict" : [_district firstObject]};


}

// 配置时间数据
- (void)configureDate
{
    NSMutableArray *hoursArray = [[NSMutableArray alloc] init];
    NSMutableArray *minutesArray = [[NSMutableArray alloc] init];
    for (NSInteger h=0; h<24; ++h) {
        [hoursArray addObject:[NSString stringWithFormat:@"%02ld",(long)h]];
    }
    _hoursArray = hoursArray;
    _hour = 0;
    
    
    for (NSInteger m=0; m<60; ++m) {
        [minutesArray addObject:[NSString stringWithFormat:@"%02ld",(long)m]];
    }
    _minutesArray = minutesArray;
    _minute = 0;
}

- (UILabel *)createCommonLabelForComponents
{
    UILabel *commonLabel = [[UILabel alloc] init];
    commonLabel.frame = CGRectMake(0, 0, 100, 30);
    commonLabel.textAlignment = NSTextAlignmentCenter;
    commonLabel.font = [UIFont systemFontOfSize:14];
    commonLabel.backgroundColor = [UIColor clearColor];
    
    return commonLabel;
}

#pragma mark -

- (BOOL)show
{
    if (_isShow) {
        return _isShow;
    }

    _isShow = YES;
    CGRect showFrame = self.frame;
    showFrame.origin.y = showFrame.origin.y - self.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = showFrame;
    }];
    return _isShow;
}

- (BOOL)dismiss
{
    if (!_isShow) {
        return _isShow;
    }

    
    _isShow = NO;
    CGRect hideFrame = self.frame;
    hideFrame.origin.y = hideFrame.origin.y  + self.frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = hideFrame;
    }];
    return _isShow;
}

#pragma mark - Public Method

- (void)showDefaultPicker
{
    BOOL show = [self show];
    if (show) {
        [self sendSubviewToBack:_datePickerView];
        [self sendSubviewToBack:_addressPickerView];
    }
}

- (void)showAddressPicker
{
    BOOL show = [self show];
    if (show) {
        [self sendSubviewToBack:_datePickerView];
        [self sendSubviewToBack:_defaultPickerView];
    }
}

- (void)showDatePicker
{
    BOOL show = [self show];
    if (show) {
        
        if (_hour > 23 && _hour < 0) {
            _hour = 0;
        }
        if (_minute > 59 && _minute < 0) {
            _minute = 0;
        }
        
        [_datePickerView selectRow:2400 + _hour inComponent:0 animated:YES];
        [_datePickerView selectRow:6000 + _minute inComponent:1 animated:YES];
        
        [self sendSubviewToBack:_addressPickerView];
        [self sendSubviewToBack:_defaultPickerView];
    }
}

#pragma mark - UIPicker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (pickerView.tag) {
        case GLDPopPickerTypeDefault: {
            if ([_dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
                return [_dataSource numberOfComponentsInPickerView:self];
            }else {
                return 0;
            }
        }
            break;
        
        case GLDPopPickerTypeAddress: {
            return 2;
        }
            break;
        
        case GLDPopPickerTypeTime: {
            return 2;
        }
            break;
            
        default:
            return 0;
            break;
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case GLDPopPickerTypeDefault: {
            if ([_dataSource respondsToSelector:@selector(popPicker:numberOfRowsInComponent:)]) {
                return [_dataSource popPicker:self numberOfRowsInComponent:component];
            }
            return 0;
        }
            break;
      
            
        case GLDPopPickerTypeAddress: {
            switch (component) {
                case 0:
                    return _province.count;
                    break;
                case 1:
                    return _city.count;
                    break;
                case 2:
                    return _district.count;
                    break;
            }
        }
            break;
            
            
        case GLDPopPickerTypeTime:
            return 65536;
            break;
    }
    return 0;
}

#pragma mark - UIPicker view delegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case GLDPopPickerTypeDefault: {
            
        }
            break;
        
        case GLDPopPickerTypeAddress: {
            return 100;
        }
            break;
            
        case GLDPopPickerTypeTime: {
            return 80;
        }
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    switch (pickerView.tag) {
            
        case GLDPopPickerTypeDefault: {
            
            if ([_delegate respondsToSelector:@selector(popPicker:viewForRow:forComponent:reusingView:)]) {
                return [_delegate popPicker:self viewForRow:row forComponent:component reusingView:view];
            }else {
                return nil;
            }
        }
            break;
            
            
        case GLDPopPickerTypeAddress: {
            
            UILabel *itemLabel = [self createCommonLabelForComponents];
            if (component == AddressTypeProvince) {
                itemLabel.text = [_province objectAtIndex:row];
            }else if (component == AddressTypeCity) {
                itemLabel.text = [_city objectAtIndex:row];
            }else {
                itemLabel.text = [_district objectAtIndex:row];
            }
            return itemLabel;
        }
            break;
            
            
        case GLDPopPickerTypeTime: {
            
            UILabel *dateLabel = [self createCommonLabelForComponents];
            dateLabel.font = [UIFont systemFontOfSize:22];
            if (component == 0) {
                dateLabel.text = [_hoursArray objectAtIndex:row%_hoursArray.count];
            }else if (component == 1) {
                dateLabel.text = [_minutesArray objectAtIndex:row%_minutesArray.count];
            }
            return dateLabel;
        }
            break;
        default:
            break;
    }
    
    return nil;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case GLDPopPickerTypeDefault: {
        }
            break;
            
        case GLDPopPickerTypeAddress: {
            NSString *province = [_currentDictionary objectForKey:@"gldprovince"];
            NSString *city = [_currentDictionary objectForKey:@"gldcity"];
            NSString *district = [_currentDictionary objectForKey:@"glddistrict"];
            
            if (component == AddressTypeProvince) {
                _currentProvince = [_province objectAtIndex:row];
                
                NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_addressDictionary objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: _currentProvince]];
                NSArray *cityArray = [dic allKeys];
                NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                    
                    if ([obj1 integerValue] > [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedDescending;//递减
                    }
                    
                    if ([obj1 integerValue] < [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedAscending;//上升
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (int i=0; i<[sortedArray count]; i++) {
                    NSString *index = [sortedArray objectAtIndex:i];
                    NSArray *temp = [[dic objectForKey: index] allKeys];
                    [array addObject: [temp objectAtIndex:0]];
                }
                
                _city = [[NSArray alloc] initWithArray: array];
                
                NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex:0]];
                _district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [_city objectAtIndex:0]]];
                [_addressPickerView selectRow:0 inComponent:AddressTypeCity animated:YES];
                [_addressPickerView reloadComponent:AddressTypeCity];
                province = [_province objectAtIndex:row];
                city = [_city objectAtIndex:0];
            }
            else if (component == AddressTypeCity) {
                NSString *provinceIndex = [NSString stringWithFormat: @"%ld", (unsigned long)[_province indexOfObject: _currentProvince]];
                NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_addressDictionary objectForKey: provinceIndex]];
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey:_currentProvince]];
                NSArray *dicKeyArray = [dic allKeys];
                NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                    if ([obj1 integerValue] > [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedDescending;
                    }
                    
                    if ([obj1 integerValue] < [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedAscending;
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
                
                if (sortedArray.count > 0 ) {
                    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
                    NSArray *cityKeyArray = [cityDic allKeys];
                    
                    _district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
                    city = [_city objectAtIndex:row];
                }
            }else if (component == AddressTypeDistrict) {
                district = [_district objectAtIndex:row];
            }
            
            NSDictionary *addDic = @{@"gldprovince" : province , @"gldcity" : city, @"glddistrict" : district };
            _currentDictionary = addDic;

            if ([_delegate respondsToSelector:@selector(popPicker:didSelectedAddress:)]) {
                ChinaAddressModel *addressModel = [[ChinaAddressModel alloc] init];
                addressModel.province = province;
                addressModel.city = city;
                addressModel.district  = district;
                [_delegate popPicker:self didSelectedAddress:addressModel];
            }
        }
            break;
            
        case GLDPopPickerTypeTime: {
            
            if (component == 0) {
                _hour = [[_hoursArray objectAtIndex:row%_hoursArray.count] integerValue];
            }else if (component == 1) {
                _minute = [[_minutesArray objectAtIndex:row%_minutesArray.count] integerValue];
            }
            
            if ([_delegate respondsToSelector:@selector(popPicker:didSelectedHour:mimute:)]) {
                NSString *hour = [NSString stringWithFormat:@"%02ld",_hour];
                NSString *minute = [NSString stringWithFormat:@"%02ld",_minute];
                [_delegate popPicker:self didSelectedHour:hour mimute:minute];
            }
        }
            break;
        default:
            break;
    }
}

@end
