//
//  SLTool.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLTool : NSObject


+(instancetype)shareTool;

//
+(AFHTTPSessionManager *)manager;

+(void )login:(NSString *)phone password:(NSString*)password success:(void (^)(id))success failure:(void (^)(NSError *))failure; // 登录接口
// 注册账号

+(void )register:(NSString *)phone codeStr:(NSString *)codeStr password:(NSString*)password success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+(void)getCode:(NSString *)phone success:(void (^)(id ) )success failure:(void (^)(NSError *))failure ; //获取验证码

// 获取任务列表
+(void)getTasks:(NSInteger )ClassID success:(void (^)(id ) )success failure:(void (^)(NSError *))failure ;

+(void)getClassification:(void (^)(id ) )success failure:(void (^)(NSError *))failure ; // 获取分类

+ (BOOL)isMobileNumber:(NSString *)mobileNum; // 手机号码判断

+(void)updatevideoOrPhoto:(NSString *)type url:(NSURL *)url image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure ; // 上传视频认证

+(void)uploadPhotos:(NSInteger)type datas:(NSArray *)datas success:(void (^)(id))success failure:(void (^)(NSError *))failure ;

// 保存数据到本地

+(void)saveToDefaults:(NSString *)name key:(NSString *)key;

// 从本地获取数据
+(NSString *)getMessageFromDefaults:(NSString *)key;
// 删除本地保存的数据
+(void)removeDefaults:(NSString *)key;
+(BOOL)isLogin; // 判断是否已经登录

@end
