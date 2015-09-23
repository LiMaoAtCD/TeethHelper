//
//  ProductConfigFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/30.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "ProductConfigFile.h"

@implementation ProductConfigFile


+(void)setProductIntroduceSource:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"product_introduce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getProductIntroduceSource{
     NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"product_introduce"];
    return temp;
}

+(void)setProductGuideSource:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"product_guide"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString *)getProductGuideSource{
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"product_guide"];
    return temp;
}

+(void)setProductIntroduceSourceThumb:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"product_introduce_thumb"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString *)getProductIntroduceSourceThumb{
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"product_introduce_thumb"];
    return temp;
}

+(void)setProductGuideSourceThumb:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"product_guide_thumb"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getProductGuideSourceThumb{
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"product_guide_thumb"];
    return temp;

}

+(void)setMeiBaiJiaoourceThumb:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"product_meibaijiao_thumb"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString *)getMeiBaiJiaoourceThumb{
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"product_meibaijiao_thumb"];
    return temp;
}

+(void)setMeiBaiJiaoource:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"product_meibaijiao"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString *)getMeiBaiJiaoource{
    
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:@"product_meibaijiao"];
    return temp;

}

@end
