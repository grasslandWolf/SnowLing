//
//  TaskItemModel.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseModel.h"

@interface TaskItemModel : BaseModel

/* 
commission		string	佣金
goods_pic_master		string	主图
name		string	名称
price		string	担保金
 
*/


@property (nonatomic,strong) NSNumber * age_max;

@property (nonatomic,strong) NSNumber * age_min;

@property (nonatomic,strong) NSNumber * height_max;

@property (nonatomic,strong) NSNumber * height_min;

@property (nonatomic,strong) NSNumber * pid;

@property (nonatomic,strong) NSNumber * level_max;

@property (nonatomic,strong) NSNumber * level_min;

@property (nonatomic,strong) NSNumber * num_left;

@property (nonatomic,strong) NSNumber * sex;

@property (nonatomic,strong) NSNumber * type; // 任务类型1佣金2赠送

@property (nonatomic,strong) NSNumber * video_auth; // 是否视频认证

@property (nonatomic,strong) NSNumber * weight_max;

@property (nonatomic,strong) NSNumber * weight_min;

@property (nonatomic,copy)  NSString * commission; // 佣金

@property (nonatomic,copy)  NSString *  goods_pic_master; // 主图

@property (nonatomic,copy)  NSString * itemName; // 

@property (nonatomic,copy)  NSString * price; // 担保金





@end
