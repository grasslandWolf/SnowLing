//
//  ClassificationModel.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseModel.h"

@interface ClassificationModel : BaseModel

@property (nonatomic,copy) NSString * classificationName;

@property (nonatomic,copy) NSString * icon;

@property (nonatomic,copy) NSNumber * pid;

@end
