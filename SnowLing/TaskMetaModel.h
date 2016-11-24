//
//  TaskMetaModel.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseModel.h"

@interface TaskMetaModel : BaseModel

@property (nonatomic,strong) NSNumber * currentPage;

@property (nonatomic,strong) NSNumber * pageCount;

@property (nonatomic,strong) NSNumber * perPage;

@property (nonatomic,strong) NSNumber * totalCount;

@end
