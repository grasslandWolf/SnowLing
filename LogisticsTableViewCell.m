//
//  LogisticsTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/9.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "LogisticsTableViewCell.h"

@implementation LogisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    if (self) {
        
        self.headImageView = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.numberLabel = [[UILabel alloc] init];
        
        [self setUp];
    }
    return self;
}

-(void)setUp {


    UIImageView * headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 60)];
    self.headImageView = headImageView;
    headImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:headImageView];
    
//    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(headImageView.superview).offset(15);
//        make.top.equalTo(headImageView.superview).offset(15);
//        make.width.and.equalTo(@60);
//    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    titleLabel.text = @"承运来源：   圆通速递";
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(headImageView.mas_right).offset(15);
        make.top.equalTo(titleLabel.superview).offset(15);
        make.right.equalTo(titleLabel.superview).offset(-20);
        make.height.equalTo(@20);
    }];
    
    UILabel * numberLabel = [[UILabel alloc] init];
    numberLabel.textAlignment = NSTextAlignmentLeft;
    numberLabel.font = [UIFont systemFontOfSize:12.0f];
    numberLabel.text = @"运单编号：   882987328350183181";
    self.numberLabel = numberLabel;
    [self addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(headImageView.mas_right).offset(15);
        make.top.equalTo(numberLabel.superview).offset(35);
        make.right.equalTo(numberLabel.superview).offset(-20);
        make.height.equalTo(@20);
    }];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
