//
//  ClassificationModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "ClassificationModel.h"

@implementation ClassificationModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    if (self) {
        self.pid = dict[@"id"];
        self.classificationName = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone  {
    
    ClassificationModel * taskModel = [[self class] allocWithZone:zone];
    
    self.classificationName = [self.classificationName copy];
    
    return taskModel;
}

@end
