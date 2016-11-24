//
//  TaskItemModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "TaskItemModel.h"

@implementation TaskItemModel

-(instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    if (self) {
        
        self.height_max = dict[@"perPage"];
        self.height_min = dict[@"totalCount"];
        self.weight_max = dict[@"pageCount"];
        self.weight_min = dict[@"currentPage"];
        self.level_max = dict[@"perPage"];
        self.level_min = dict[@"totalCount"];
        self.age_max = dict[@"pageCount"];
        self.age_min = dict[@"currentPage"];
        self.pid = dict[@"perPage"];
        self.num_left = dict[@"totalCount"];
        self.sex = dict[@"pageCount"];
        self.video_auth = dict[@"currentPage"];
        
        
        self.commission = dict[@"perPage"];
        self.goods_pic_master = dict[@"totalCount"];
        self.price = dict[@"pageCount"];
        self.itemName = dict[@"currentPage"];
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone  {
    
    TaskMetaModel * taskModel = [[self class] allocWithZone:zone];
    
   
    
    
    return taskModel;
}


@end
