//
//  TeethStateConfigureFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeethStateConfigureFile : NSObject


+(void)setGender:(NSInteger)gender;
+(NSInteger)gender;

+(void)setAgeScope:(NSInteger)scope;
+(NSInteger)ageScope;



//健康状况等级
+(void)setTeethStateLevel:(NSInteger)level;
+(NSInteger)teethLevel;

//是否敏感
+(void)setSensitive:(BOOL)sensitive;
+(BOOL)isSensitive;

//意愿是否强烈
+(void)WillStrong:(BOOL)strong;
+(BOOL)isWillStrong;


@end
