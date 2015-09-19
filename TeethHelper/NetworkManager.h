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
 *  发布图片加文字
 *
 *  @param content           文字
 *  @param images            图片数组
 *  @param completionHandler
 *  @param failHandler
 */
+(void)publishTextContent:(NSString *)content withImages:(NSArray*)images WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

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
+(void)replyToID:(NSString *)topicID ByCommentContent:(NSString*)content WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

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

/**
 *  获取首页数据
 *
 *  @param completionHandler
 *  @param failHandler
 */
+(void)fetchFirstPageWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;



/**
 *  首次问卷提交
 *
 *  @param sex               Q1> A:男，B:女
 *  @param age                Q2> A:'20岁以下',B:'20岁-25岁',C:'25岁-30岁',D:'30岁-35岁',E:'35岁-40岁',F:'40岁以上'
 *  @param health            Q3> A:好，B:一般，C:不好，D:不知道
 *  @param sensitived        Q4> A:是，B:否
 *  @param intention         Q5> A:很强，希望马上实现, B:还好，等几天也可以
 *  @param completionHandler
 *  @param failHandler
 */
+(void)uploadFirstQuestionsSex:(NSString *)sex age:(NSString *)age health:(NSString *)health sensitived:(NSString*)sensitived intention:(NSString*)intention WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;



/**
 *  上传测白数据
 *
 *  @param isFrist           如果是首次测白，此参数传true，其他情况可以不用传或者false
 *  @param image             测白的图片
 *  @param color             测白的色阶
 *  @param defeat            测白打败的百分比，数字即可
 *  @param completionHandler
 *  @param failHandler
 */
+(void)uploadCeBaiisFirst:(NSString *)isFirst file:(UIImage *)image color:(NSString *)color defeat:(NSString *)defeat WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;





/**
 *  修改当前美白计划至某个计划
 *
 *  @param projectID         计划
 *  @param completionHandler
 *  @param failHandler
 */
+(void)ModifyProject:(NSString *)projectID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  开始美白（美白计划开始时上传数据以便服务器统计时间）
 *
 *  @param completionHandler
 *  @param failHandler
 */
+(void)BeginMeiBaiProjectWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  结束美白
 *
 *  @param completionHandler
 *  @param failHandler
 */
+(void)EndMeiBaiProjectWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


/**
 *  美白程序-用后问卷
 *
 *  @param totalTime         Q1> A:3次共24分钟，B:4次公32分钟，C:5次共40分钟，D:6次共48分钟，E:7次共56分钟
 *  @param feel              Q2> A:无，B:轻微酸痛感，C:严重酸痛感
 *  @param completionHandler
 *  @param failHandler
 */
+(void)CompletedMeibaiQuestionByTotalTime:(NSString *)totalTime feel:(NSString *)feel WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  使用记录
 *
 *  @param startIndex
 *  @param pageSize
 *  @param completionHandler
 *  @param failHandler
 */
+(void)fetchUseHistoryStartIndex:(NSInteger)startIndex andPageSize:(NSInteger)pageSize WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

/**
 *  测白记录
 *
 *  @param startIndex
 *  @param pageSize
 *  @param completionHandler
 *  @param failHandler
 */
+(void)fetchCeBaiHistoryStartIndex:(NSInteger)startIndex andPageSize:(NSInteger)pageSize WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;





/**
 *  查询当前美白计划
 *
 *  @param completionHandler
 *  @param failHandler
 */
+(void)FetchCurrrentProjectWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;
/**
 *  修改次数或天数
 *
 *  @param times             次数
 *  @param days              天数
 *  @param planID            计划ID
 *  @param completionHandler
 *  @param failHandler
 */
+(void)ModifyTimes:(NSInteger)times Days:(NSInteger)days OnPlanID:(long)planID WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

//切换当前计划
+(void)SwitchCurrentProjectWithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;


//上传满意度问卷答案
+(void)uploadSatisfiedQuestionAnswers:(NSArray *)answer1 WithCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler;

@end
