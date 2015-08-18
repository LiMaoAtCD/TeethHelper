//
//  AccountManager.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject


//是否登录
+(BOOL)isLogin;
+(void)setLogin:(BOOL)login;

//tokenID
+(NSString*)getTokenID;
+(void)setTokenID:(NSString*)token;

//性别
+(void)setgender:(NSString*)gender;
+(NSString*)getGender;
//地址
+(NSString*)getAddress;
+(void)setAddress:(NSString*)address;

//密码
+(NSString*)getPassword;
+(void)setPassword:(NSString*)password;

//手机号
+(NSString*)getCellphoneNumber;
+(void)setCellphoneNumber:(NSString*)cellphone;

//昵称
+(NSString*)getName;
+(void)setName:(NSString*)name;

//头像
+(NSString*)getAvatarUrlString;
+(void)setAvatarUrlString:(NSString*)url;

//生日
+(NSString*)getBirthday;
+(void)setBirthDay:(NSString*)birthday;


@end
