//
//  AdressModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AdressModel.h"
@implementation AdressModel

-(instancetype)initWithDict:(NSDictionary *)dict {

    self = [super initWithDict:dict];
    if (self) {
        
    }
    return self;
}

+(NSArray*)getList:(NSDictionary *)dict {
    NSMutableArray * list = [NSMutableArray array];
    
    for ( NSDictionary * json in dict ) {
        
        AdressModel * model = [[AdressModel alloc] initWithDict:json];
        [list addObject:model];
        
    }
    return list;
}
@end
