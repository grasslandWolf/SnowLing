//
//  OrderIntegralTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClick)();

@interface OrderIntegralTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,strong) UIButton * payBtn;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UITextField * IntegralTF;

@property (nonatomic,copy) buttonClick btnClick;

@property (nonatomic,strong) UILabel * repayLabel;  //抵账

@property (nonatomic,strong) UILabel * remainLabel;  //剩余积分




@end
