//
//  BaseModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        self.name = dict[@"name"];
        self.password = dict[@"password"];
        self.code = dict[@"code"];
        
        self.success = dict[@"success"];
        self.message = dict[@"msg"];
    }
    return self;
}

+(instancetype)modelWithDict:(NSDictionary *)dict {

    return [[self alloc] initWithDict:dict];
}
-(id)copyWithZone:(NSZone *)zone {

    BaseModel * model = [[self class] allocWithZone:zone];
    model.message = [self.message copy];
    
    
    return model;
}

+(NSArray*)getList:(NSDictionary *)dict {

    return nil;
}

@end
