//
//  AngleNumberView.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/3.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AngleNumberDelegate <NSObject>

-(void)getNumber;

@end

@interface AngleNumberView : UIView

@property (nonatomic,strong) UIButton * carBtn;

@property (nonatomic,strong) UILabel * numberLabel;

@property (nonatomic,assign) id<AngleNumberDelegate>delegate;

// 为购物车设置角标内数值

- (void)setShopCarCount:(NSString *)count;

@end
