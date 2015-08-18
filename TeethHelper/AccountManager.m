//
//  AccountManager.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

+(BOOL)isLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
   BOOL islogin = [defaults boolForKey:@"Account_login"];
    return islogin;
}
+(void)setLogin:(BOOL)login{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:login forKey:@"Account_login"];
    [defaults synchronize];
}

//tokenID
+(NSString*)getTokenID{
    NSString *token  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_token_id"];
    
    return token;
}
+(void)setTokenID:(NSString*)token{
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"user_token_id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//性别

+(void)setgender:(NSString *)gender{
    [[NSUserDefaults standardUserDefaults] setObject:gender forKey:@"user_gender"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString *)getGender{
    
    NSString *gender  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_gender"];
    return gender;

}

//地址

+(NSString*)getAddress{
    NSString *address  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_address"];
    return address;
}

+(void)setAddress:(NSString*)address{
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"user_address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//密码

+(NSString*)getPassword{
    NSString *password  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_password"];
    return password;
}
+(void)setPassword:(NSString*)password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"user_password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//手机号

+(NSString*)getCellphoneNumber{
    NSString *phone  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_phone"];
    return phone;
}
+(void)setCellphoneNumber:(NSString*)cellphone{
    [[NSUserDefaults standardUserDefaults] setObject:cellphone forKey:@"user_phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//昵称
+(NSString*)getName{
    NSString *name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
    return name;
}
+(void)setName:(NSString*)name{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//头像
+(NSString*)getAvatarUrlString{
    NSString *avatar  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_avatar"];
    return avatar;
}
+(void)setAvatarUrlString:(NSString*)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"user_avatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//生日
+(NSString*)getBirthday{
    NSString *birthday  = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_birthday"];
    return birthday;
}
+(void)setBirthDay:(NSString*)birthday{
    [[NSUserDefaults standardUserDefaults] setObject:birthday forKey:@"user_birthday"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}


@end
