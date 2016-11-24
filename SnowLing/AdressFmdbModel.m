//
//  AdressFmdbModel.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/17.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AdressFmdbModel.h"

@implementation AdressFmdbModel

-(instancetype)initWithDict:(NSDictionary *)dict {

    self = [super initWithDict:dict];
    if (self) {
        
        self.consigneeName = dict[@"consigneeName"];
        self.phone = dict[@"phone"];
        self.adress = dict[@"adress"];
        self.detailAdress = dict[@"detailAdress"];
       // self.addressID = [dict[@"addressID"] integerValue];
    }
    return self;
}
+(instancetype)modelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
-(id)copyWithZone:(NSZone *)zone {
    
    AdressFmdbModel * model = [[self class] allocWithZone:zone];
    model.consigneeName = [self.consigneeName copy];
    model.adress = [self.adress copy];
    model.detailAdress = [self.detailAdress copy];
    
    
    return model;
}


@end
