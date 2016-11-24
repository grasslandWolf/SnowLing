//
//  AccountTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/10.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountCellDelegate <NSObject>



@end

@interface AccountTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) NSString * name;

@property (nonatomic,assign) id <AccountCellDelegate>delegate;



@end
