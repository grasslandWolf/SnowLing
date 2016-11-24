//
//  CollectionAndLikeManager.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/17.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "CollectionAndLikeManager.h"

#import "AdressFmdbModel.h"

@implementation CollectionAndLikeManager
static FMDatabase * _db;

+(void)initialize {

    //1.打开数据库
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"address.sqlite"];
    
    _db = [FMDatabase databaseWithPath:file];
    if (![_db open]) {
        return;
    }
    // address_id integer,
    [_db executeUpdate:@"create table if not exists t_address(id integer PRIMARY KEY,address_adressStr text not NULL,address_detailStr text not NULL, address_phone text not NULL,adress_consigneeName text not NULL)"];
   // [_db executeUpdate:@"create table if not exists t_address(id integer PRIMARY KEY,address_adressStr text not NULL,address_detailStr text not NULL)"];
}
+(NSArray*)addressCounts:(int)page {
    
    int size = 10;//每页size条数据
    int pos = (page -1)*size;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * FROM t_address ORDER BY id DESC LIMIT %d,%d",pos,size];// limt 的作用，从pos位置开始的size 条数据
    NSMutableArray *arr = [NSMutableArray array];
    while ([set next]) {
        
//        NSData *data = [set objectForColumnName:@"t_address"];
//        AdressFmdbModel *clothesInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSString * clothesInfo = [set objectForColumnName:@"address_phone"];
        [arr addObject:clothesInfo];
    }
    
    return arr;

}
+(int)adressCount {

    return  [_db intForQuery:@"select count(*) from t_address"];
}
// 增加地址
+(void)addAdress:(AdressFmdbModel *)adressInfo {

    [_db executeUpdateWithFormat:@"insert into t_address(address_adressStr,address_detailStr,address_phone,adress_consigneeName) values(%@,%@,%@,%@)",adressInfo.adress,adressInfo.detailAdress,adressInfo.phone,adressInfo.consigneeName];

}
+(void)revoveAdress:(AdressFmdbModel *)adressInfo {
   
    [_db executeUpdateWithFormat:@"delete from t_address where address_phone = %@",adressInfo.phone];

}

+(void)changeAdress:(AdressFmdbModel *)addressInfo {
    

    [_db executeUpdateWithFormat:@"update t_address set  address_phone = %@ ",addressInfo.phone];
    [_db executeUpdateWithFormat:@"update t_address set adress_consigneeName = %@ where  address_phone = %@",addressInfo.consigneeName,@"56784321"];
    
}

@end
