//
//  AddAdressTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)();

@interface AddAdressTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UITextField * titleTF;

@property (nonatomic,strong) UIButton * locationbtn;// 定位

@property (nonatomic,copy) buttonClick btnClick;

@end
