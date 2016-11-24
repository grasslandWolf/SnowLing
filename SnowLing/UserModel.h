//
//  UserModel.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * token;

@property (nonatomic,assign) NSNumber * uid;

@end
