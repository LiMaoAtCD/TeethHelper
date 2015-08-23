//
//  NetworkManager.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/9.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^NetWorkHandler)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^NetWorkFailHandler)(AFHTTPRequestOperation *operation,NSError *error);

@interface NetworkManager : NSObject
/**
 *  注册
 *
 *  @param nickName   昵称
 *  @param phone      电话
 *  @param password   密码
 *  @param verifyCode 验证码
 */
+(void)RegisterByNickname:(NSString *)nickName phone:(NSString *)phone password:(NSString *)password verifyCode:(NSString*)verifyCode withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  登录（非三方）
 *
 *  @param username          用户名
 *  @param password          密码
 *  @param completionHandler
 *  @param failHandler
 */
+(void)LoginByUsername:(NSString *)username password:(NSString *)password withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  三方登录
 *
 *  @param thirdId           三方唯一ID
 *  @param provider          提供方：WEIXIN
 *  @param userAliasName     三方昵称
 *  @param userAvatar        三方头像
 *  @param completionHandler
 *  @param failHandler
 */
+(void)ThirdLoginByThirdID:(NSString*)thirdId provider:(NSString *)provider userAliasName:(NSString *)userAliasName userAvatar:(NSString *)userAvatar withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  注销
 *
 *  @param accessToken       token
 *  @param completionHandler
 *  @param failHandler
 */
+(void)LogoutByToken:(NSString*)accessToken withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  获取注册验证码
 *
 *  @param phone             手机号码
 *  @param completionHandler
 *  @param failHandler
 */
+(void)FetchVerifyCode:(NSString *)phone withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  忘记密码获取验证码
 *
 *  @param phone             电话号码
 *  @param completionHandler
 *  @param failHandler
 */
+(void)FetchForgetVerifyCode:(NSString *)phone withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  忘记密码
 *
 *  @param phone             手机号
 *  @param verifyCode        验证码
 *  @param password          密码
 *  @param completionHandler
 *  @param failHandler       
 */
+(void)ForgetPassword:(NSString*)phone verifyCode:(NSString*)verifyCode password:(NSString*)password withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  修改用户信息
 *
 *  @param nickName          昵称
 *  @param sex               性别
 *  @param birthday          生日
 *  @param address           地址
 *  @param completionHandler
 *  @param failHandler
 */
+(void)EditUserNickName:(NSString *)nickName sex:(NSString *)sex birthday:(NSString *)birthday address:(NSString *)address withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  上传头像
 *
 *  @param image              头像
 *  @param completionHandler
 *  @param failHandler
 */
+(void)UploadAvatarImageFile:(UIImage *)image withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  获取产品信息
 *
 *  @param completionHandler
 *  @param failHandler
 */
+(void)fetchProductInfoWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  发布文字帖子
 *
 *  @param content           文字信息
 *  @param completionHandler
 *  @param failHandler
 */
+(void)publishTextContent:(NSString *)content WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;
/**
 *  获取帖子列表
 *
 *  @param index             索引
 *  @param pageSize          帖子数
 *  @param completionHandler
 *  @param failHandler
 */
+(void)fetchPostsByStartIndex:(NSInteger)index pageSize:(NSInteger)pageSize WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  回复帖子
 *
 *  @param topicID           帖子ID
 *  @param completionHandler
 *  @param failHandler
 */
+(void)replyToID:(NSString *)topicID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  获取帖子详情
 *
 *  @param topicID           帖子ID
 *  @param completionHandler
 *  @param failHandler
 */
+(void)fetchTopicDetailByTopicID:(NSString*)topicID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  点赞
 *
 *  @param topicID           帖子ID
 *  @param completionHandler
 *  @param failHandler
 */
+(void)LikeTopicByID:(NSString*)topicID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

@end
