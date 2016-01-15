//
//  DateFormaterCenter.m
//  TeethHelper
//
//  Created by AlienLi on 16/1/15.
//  Copyright © 2016年 MarcoLi. All rights reserved.
//

#import "DateFormaterCenter.h"

@implementation DateFormaterCenter

+(instancetype)sharedDateFormatter{
    
    static DateFormaterCenter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[DateFormaterCenter alloc] init];
        if (dateFormatter) {
            dateFormatter->_formatter = [[NSDateFormatter alloc] init];
        }
    });
    
    return dateFormatter;
}

@end
