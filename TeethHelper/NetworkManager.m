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

+(void)fetchProductInfoWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSString *url = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/product?accessToken=%@",[AccountManager getTokenID]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:url parameters:nil success:completionHandler failure:failHandler];

}

+(void)publishTextContent:(NSString *)content withImages:(NSArray*)images WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (content) {
        dictionary[@"content"] = content;
    } else{
        dictionary = nil;
    }
    NSString *string = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/topic/publish?accessToken=%@",[AccountManager getTokenID]];
    
    NSMutableArray *imageDataArray = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImage *image = obj;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);

        [imageDataArray addObject:imageData];
    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
    [manager POST:string parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < imageDataArray.count; i++) {
            [formData appendPartWithFileData:imageDataArray[i] name:@"files" fileName:@"file.jpg" mimeType:@"image/jpeg"];
        }
    } success:completionHandler failure:failHandler];
    
    
    
    
}

+(void)publishTextContent:(NSString *)content WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (content) {
        dictionary[@"content"] = content;
    }
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/topic/publishonlycon" parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)fetchPostsByStartIndex:(NSInteger)index pageSize:(NSInteger)pageSize WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{

    
    NSString *url = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/topic?accessToken=%@&startIndex=%ld&pageSize=%ld", [AccountManager getTokenID],index,pageSize];
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:completionHandler failure:failHandler];

}

+(void)replyToID:(NSString *)topicID ByCommentContent:(NSString*)content WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    dictionary[@"content"] = content;
    NSString *url = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/topic/%@/reply",topicID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)fetchTopicDetailByTopicID:(NSString*)topicID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    NSString *url = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/topic/%@",topicID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)LikeTopicByID:(NSString*)topicID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
//    http://www.7wang523.com/teeth-api/topic/2/love
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    NSString *url = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/topic/%@/love",topicID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:dictionary success:completionHandler failure:failHandler];
}



+(void)fetchFirstPageWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    NSString *url = @"http://www.7wang523.com/teeth-api/index";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:dictionary success:completionHandler failure:failHandler];
}

+(void)uploadFirstQuestionsSex:(NSString *)sex age:(NSString *)age health:(NSString *)health sensitived:(NSString*)sensitived intention:(NSString*)intention WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"sex"] = sex;
    dictionary[@"age"] = age;
    dictionary[@"health"] = health;
    dictionary[@"sensitived"] = sensitived;
    dictionary[@"intention"] = intention;

    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://www.7wang523.com/teeth-api/index/asq" parameters:dictionary success:completionHandler failure:failHandler];
}
+(void)uploadCeBaiisFirst:(NSString *)isFirst file:(UIImage *)image color:(NSString *)color defeat:(NSString *)defeat WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (isFirst) {
        dictionary[@"isFirst"] = @"true";
    }
    
    dictionary[@"color"] = color;
    dictionary[@"defeat"] = defeat;
    
//    dictionary[@"accessToken"] = [AccountManager getTokenID];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://www.7wang523.com/teeth-api/test?accessToken=%@",[AccountManager getTokenID]];
    
    [manager POST:url parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
    } success:completionHandler failure:failHandler];
}

@end
