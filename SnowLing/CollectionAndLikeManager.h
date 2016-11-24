//
//  CollectionAndLikeManager.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/17.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AdressFmdbModel;
@interface CollectionAndLikeManager : NSObject

+(int)adressCount;

+(void)addAdress:(AdressFmdbModel *)adressInfo; // 添加地址

+(void)revoveAdress:(AdressFmdbModel *)adressInfo; // 删除地址

+ (NSArray*)addressCounts:(int)page; // 获取表中的内容

+(void)changeAdress:(AdressFmdbModel*)addressInfo; // 修改地址

@end
