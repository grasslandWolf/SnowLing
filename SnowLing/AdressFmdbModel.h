//
//  AdressFmdbModel.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/17.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseModel.h"

@interface AdressFmdbModel : BaseModel

// @property (nonatomic,assign) NSInteger addressID;

@property (nonatomic,copy) NSString * consigneeName; // 收货人

@property (nonatomic,copy) NSString * phone; //电话号码

@property (nonatomic,copy) NSString * adress;// 地址

@property (nonatomic,copy) NSString * detailAdress; //详细地址


@end
