//
//  TaskMetaModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "TaskMetaModel.h"

@implementation TaskMetaModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    if (self) {
        self.perPage = dict[@"perPage"];
        self.totalCount = dict[@"totalCount"];
        self.pageCount = dict[@"pageCount"];
        self.currentPage = dict[@"currentPage"];
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone  {
    
    ClassificationModel * taskModel = [[self class] allocWithZone:zone];
    
    self.currentPage = [self.currentPage copy];
    self.pageCount = [self.pageCount copy];
    self.totalCount = [self.totalCount copy];
    self.perPage = [self.perPage copy];

    
    return taskModel;
}

@end
