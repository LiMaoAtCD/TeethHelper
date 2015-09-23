//
//  ProductConfigFile.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/30.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductConfigFile : NSObject

+(void)setProductIntroduceSource:(NSString *)url;
+(NSString *)getProductIntroduceSource;

+(void)setProductGuideSource:(NSString *)url;
+(NSString *)getProductGuideSource;

+(void)setProductIntroduceSourceThumb:(NSString *)url;
+(NSString *)getProductIntroduceSourceThumb;

+(void)setProductGuideSourceThumb:(NSString *)url;
+(NSString *)getProductGuideSourceThumb;

+(void)setMeiBaiJiaoourceThumb:(NSString *)url;
+(NSString *)getMeiBaiJiaoourceThumb;

+(void)setMeiBaiJiaoource:(NSString *)url;
+(NSString *)getMeiBaiJiaoource;


@end
