//
//  OrderPayViewController.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/12.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseTableViewController.h"

@interface OrderPayViewController : BaseTableViewController

@property (nonatomic,assign) NSInteger index; // 是那种支付方式

@property (nonatomic,assign) NSInteger paytype; // 1 余额支付 2 第三方支付

@property (nonatomic,assign) BOOL isSelected; // 是否使用积分

@end
