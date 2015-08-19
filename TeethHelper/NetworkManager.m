//
//  NetworkManager.m
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import "NetworkManager.h"
#import "AccountManager.h"
@implementation NetworkManager


+(void)RegisterByNickname:(NSString *)nickName phone:(NSString *)phone password:(NSString *)password verifyCode:(NSString*)verifyCode withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"nickName":nickName,@"phone":phone,@"password":password,@"verifyCode":verifyCode};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/user/register" parameters:dictionary success:completionHandler failure:failHandler];
}


+(void)LoginByUsername:(NSString *)username password:(NSString *)password withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"username":username,@"password":password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/auth/token" parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)ThirdLoginByThirdID:(NSString*)thirdId provider:(NSString *)provider userAliasName:(NSString *)userAliasName userAvatar:(NSString *)userAvatar withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"thirdId":thirdId,@"provider":provider,@"userAliasName":userAliasName,@"userAvatar":userAvatar};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/auth/token" parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)LogoutByToken:(NSString*)accessToken withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"accessToken":accessToken};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/auth/logout" parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)FetchVerifyCode:(NSString *)phone withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"phone":phone};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/user/register/verifycode" parameters:dictionary success:completionHandler failure:failHandler];

}
+(void)FetchForgetVerifyCode:(NSString *)phone withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"phone":phone};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/user/verifycode" parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)ForgetPassword:(NSString*)phone verifyCode:(NSString*)verifyCode password:(NSString*)password withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSDictionary *dictionary = @{@"phone":phone,@"verifyCode":verifyCode,@"password":password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/password/forget" parameters:dictionary success:completionHandler failure:failHandler];

}

+(void)EditUserNickName:(NSString *)nickName sex:(NSString *)sex birthday:(NSString *)birthday address:(NSString *)address withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (nickName) {
        dictionary[@"nickName"] = nickName;
    }
    if (sex) {
        dictionary[@"sex"] = sex;
    }
    if (birthday) {
        dictionary[@"birthday"] = birthday;
    }
    if (address) {
        dictionary[@"address"] = address;
    }
    
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/user/complete" parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)UploadAvatarImageFile:(UIImage *)image withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    NSString *string = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/user/upload?accessToken=%@",dictionary[@"accessToken"]];

    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:string parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
    } success:completionHandler failure:failHandler];

}


@end
