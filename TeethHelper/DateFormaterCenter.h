//
//  DateFormaterCenter.h
//  TeethHelper
//
//  Created by AlienLi on 16/1/15.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormaterCenter : NSObject

@property (nonatomic, strong) NSDateFormatter *formatter;

+(instancetype)sharedDateFormatter;

@end
