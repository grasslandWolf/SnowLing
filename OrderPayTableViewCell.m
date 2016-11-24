//
//  OrderPayTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/12.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "OrderPayTableViewCell.h"

@implementation OrderPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImageView = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.payBtn = [[UIButton alloc] init];
        [self setup];
        
    }
    return self;
}
-(void)setup {

    UIImageView * headImageView = [[UIImageView alloc] init];
    self.headImageView = headImageView;
    [self addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textColor = COLOR_141;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.mas_left).offset(55);
        make.top.equalTo(self.mas_top).offset(15);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];

    
    UIButton * payBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = COLOR_CLEAR;
    payBtn.layer.cornerRadius = 7.5f;
    payBtn.layer.borderWidth = 0.5f;
    payBtn.layer.borderColor = COLOR_141.CGColor;
    payBtn.layer.masksToBounds = YES;
    self.payBtn = payBtn;
    [self addSubview:payBtn];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(18);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
