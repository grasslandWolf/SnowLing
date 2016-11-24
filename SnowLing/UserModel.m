//
//  UserModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(instancetype)initWithDict:(NSDictionary *)dict {

    self = [super initWithDict:dict];
    if (self) {
        self.uid = dict[@"id"];
        self.phone = dict[@"phone"];
        self.token = dict[@"token"];
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone  {
    
    UserModel * taskModel = [[self class] allocWithZone:zone];
    
    self.token = [self.token copy];
    
    return taskModel;
}

@end
