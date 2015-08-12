//
//  TeethStateConfigureFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeethStateConfigureFile : NSObject


//健康状况等级
+(void)setTeethStateLevel:(NSInteger)level;
+(NSInteger)teethLevel;

//是否敏感
+(void)setSensitive:(BOOL)sensitive;
+(BOOL)isSensitive;

//
+(void)WillStrong:(BOOL)strong;
+(BOOL)isWillStrong;

@end
