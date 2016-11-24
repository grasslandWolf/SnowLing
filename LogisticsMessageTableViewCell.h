//
//  LogisticsMessageTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/9.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsMessageTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel * titleLabel; // 物流详情

@property (nonatomic,strong) UILabel * dataLabel; // 显示日期

@property (nonatomic,strong) UIView * grayView; // 灰色

@property (nonatomic,strong) UIImageView * redImageView; // 第一个

@property (nonatomic,strong) NSString * title; // 物流信息内容

-(void)getTitle:(NSString *)title;

@end
