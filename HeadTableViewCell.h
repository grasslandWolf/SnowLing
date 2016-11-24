//
//  HeadTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/7.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadTableViewCellDeledate <NSObject>

-(void)reloadMessage:(NSInteger)index;

@end

@interface HeadTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView * colorView;

@property (nonatomic,assign) id<HeadTableViewCellDeledate>delegate;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) UIButton * lastBtn;



@end
