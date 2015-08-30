//
//  TeethStateConfigureFile.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/12.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "TeethStateConfigureFile.h"

@implementation TeethStateConfigureFile


+(void)setGender:(NSInteger)gender{
    [[NSUserDefaults standardUserDefaults] setInteger:gender forKey:@"teeth_health_gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)gender{
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"teeth_health_gender"];
    return level;
}

+(void)setAgeScope:(NSInteger)scope{
    [[NSUserDefaults standardUserDefaults] setInteger:scope forKey:@"teeth_health_age_scope"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)ageScope{
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"teeth_health_age_scope"];
    return level;
}


//健康状况等级
+(void)setTeethStateLevel:(NSInteger)level{
    [[NSUserDefaults standardUserDefaults] setInteger:level forKey:@"teeth_health_level"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSInteger)teethLevel{
    
    NSInteger level = [[NSUserDefaults standardUserDefaults] integerForKey:@"teeth_health_level"];
    return level;
}

//是否敏感
+(void)setSensitive:(BOOL)sensitive{
    [[NSUserDefaults standardUserDefaults] setBool:sensitive forKey:@"teeth_sensitive"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)isSensitive{
    BOOL sensitive = [[NSUserDefaults standardUserDefaults] boolForKey:@"teeth_sensitive"];
    return sensitive;
}

//
+(void)WillStrong:(BOOL)strong{
    [[NSUserDefaults standardUserDefaults] setBool:strong forKey:@"teeth_strong"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(BOOL)isWillStrong{
    BOOL istrong = [[NSUserDefaults standardUserDefaults] boolForKey:@"teeth_strong"];
    return istrong;
}

@end
