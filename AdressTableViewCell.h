//
//  AdressTableViewCell.h
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  AdressTableViewCellDelegate<NSObject>

-(void)deleteAdress:(UIButton *)sender;  // 删除地址
-(void)editAdress:(UIButton*)sender; // 修改地址

@end

@interface AdressTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;

@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailAdressLabel;
@property (strong, nonatomic) IBOutlet UIButton *defaultAdressBtn;
@property (nonatomic,assign) id<AdressTableViewCellDelegate>delegate;

@property (nonatomic,strong) AdressFmdbModel * ADmodel;
-(void)getModel:(AdressFmdbModel*)ADmodel;

@end
