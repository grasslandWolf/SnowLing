//
//  SLTool.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "SLTool.h"

@implementation SLTool



+(instancetype)shareTool {

    static SLTool * tool = nil;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init] ;
    }) ;
    
    return tool ;

}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [SLTool shareTool] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [SLTool shareTool] ;
}



+(AFHTTPSessionManager*)manager {


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSTimeInterval timeInterval = 30;
    manager.requestSerializer.timeoutInterval =timeInterval;
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    return manager;
}

// 登录
+(void )login:(NSString *)phone password:(NSString *)password success:(void (^)(id ) )success failure:(void (^)(NSError *))failure {
    
    
    NSString * url = [NSString stringWithFormat:@"%@/login",KURL];
    
    NSDictionary * dict = @{@"mphone":phone,
                            @"password":password
                            };
   [ [SLTool manager] POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
       
       
       
       if (success) {
           success(responseObject);
       }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            
            failure(error);

        }
    }];
    

}
// 注册
+(void)register:(NSString *)phone codeStr:(NSString *)codeStr password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    NSString * url = [NSString stringWithFormat:@"%@/register",KURL];
    NSDictionary * dict = @{ @"mphone":phone,
                             @"code":codeStr,
                             @"password":password,};
    [[SLTool manager] POST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success){
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(failure){
        
            failure(error);}
        
    }];

}

// 获取验证码
+(void)getCode:(NSString *)phone success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    NSString * url = [NSString stringWithFormat:@"%@/sms/send/phone/%@",KURL,phone];
    
    [[SLTool manager] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}
// 任务列表
+(void)getTasks:(NSInteger )ClassID success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    static NSString * url = nil;
//    if (class == 0) {
//        
//        url = [NSString stringWithFormat:@"%@/v1/tasks/",KURL];
//
//    } else {
//    
//       
//
//    }
//    
     url = [NSString stringWithFormat:@"%@/v1/tasks/class/%ld",KURL,(long)ClassID];
    [[SLTool manager] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
// 任务分类
+(void)getClassification:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString * url = [NSString stringWithFormat:@"%@/v1/classes",KURL];
    
    [[SLTool manager] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];

}
// 上传照片或者视频认证
+(void)updatevideoOrPhoto:(NSString *)type url:(NSURL *)url  image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    NSString * URL = [NSString stringWithFormat:@"%@/upload",KURL];
    
    NSDictionary * dict = @{@"type":type};
    
    [[SLTool manager] POST:URL parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if ([type isEqualToString:@"AUTH_VIDEO"]) {
           // [formData appendPartWithFormData:data name:@"file"];

            [formData appendPartWithFileURL:url name:@"file" error:nil];
            
        } else if ([type isEqualToString:@"AVATOR"]){
            NSData * data = UIImageJPEGRepresentation(image, 1);
            [formData appendPartWithFileData:data name:@"file" fileName:@".jpg" mimeType:@"image/jpg"];
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

    
}

// 上传图片认证
+(void)uploadPhotos:(NSInteger)type datas:(NSArray *)datas success:(void (^)(id))success failure:(void (^)(NSError *))failure {

    
    NSString * url = [NSString stringWithFormat:@"%@/v1/auths/create",KURL];
    
    NSString * token = [SLTool getMessageFromDefaults:TokenKey];
    
    NSDictionary * dictionary = @{@(type):@"type",
                                  token:@"token"};
    
    [[SLTool manager] POST:url parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i< datas.count; i++) {
            
            NSURL * url = [NSURL URLWithString:datas[i]];
//            NSData * data = [NSData dataWithContentsOfFile:datas[i]];
//            [formData appendPartWithFormData:data name:@"files[]"];
            [formData appendPartWithFileURL:url
                                       name:@"files[]" error:nil];
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    

    

}
+(void)saveToDefaults:(NSString *)name key:(NSString *)key {

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:name forKey:key];
    [userDefaults synchronize];
    
}

+(NSString *)getMessageFromDefaults:(NSString *)key {

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
      NSString *str =  [userDefaults objectForKey:key];

    return str;
}

+(void)removeDefaults:(NSString *)key {

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}
// 判断是不是手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+(BOOL)isLogin {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token =  [userDefaults objectForKey:TokenKey];
    
    if ([token isEqualToString:@""] || token == nil) {
        
        return NO;
    } else {
    
        return YES;
    }

}
@end
