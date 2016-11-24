//
//  AccountTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/10.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        
    }
    return self;
}
-(void)setUp {

    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textColor = COLOR_141;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(titleLabel.superview).offset(15);
        make.top.equalTo(titleLabel.superview).offset(15);
        make.right.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIButton * accountBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [accountBtn setTitle:self.name forState:UIControlStateNormal];
    [accountBtn setTitleColor:COLOR_141 forState:UIControlStateNormal];
    [accountBtn addTarget:self action:@selector(Account:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:accountBtn];
    
    [accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_bottom).offset(47);
        make.left.equalTo(accountBtn.superview).offset(15);
        make.right.equalTo(accountBtn.superview).offset(-15);
        make.height.equalTo(@40);
        
    }];


}
-(void)Account:(UIButton *)sender {


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
