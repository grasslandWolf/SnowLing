//
//  BaseModel.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * password;

@property (nonatomic,copy) NSString * code;

@property (nonatomic,assign) NSNumber * success;

@property (nonatomic,copy) NSString * message;



//将字典内的值赋给申明的相应属性
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
+(NSArray *)getList:(NSDictionary *)dict;

@end
