//
//  LogisticsTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/9.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * headImageView; 

@property (nonatomic,strong) UILabel * titleLabel; // 物流公司名称

@property (nonatomic,strong) UILabel * numberLabel; //物流编号

@end
