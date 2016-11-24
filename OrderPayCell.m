//
//  OrderPayCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/12.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "OrderPayCell.h"

@implementation OrderPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.securityLabel = [[UILabel alloc] init];
        self.actulPayLabel = [[UILabel alloc] init];
        [self setUp];
    }
    return self;
}
-(void)setUp {

    UILabel * securityLabel = [[UILabel alloc] init];
    securityLabel.textAlignment = NSTextAlignmentLeft;
    securityLabel.font = [UIFont systemFontOfSize:14.0f];
    securityLabel.textColor = COLOR_141;
    self.securityLabel = securityLabel;
    [self addSubview:securityLabel];
    
    [securityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UILabel * actulPayLabel = [[UILabel alloc] init];
    actulPayLabel.textAlignment = NSTextAlignmentRight;
    actulPayLabel.font = [UIFont systemFontOfSize:14.0f];
    actulPayLabel.textColor = COLOR_50;
    self.actulPayLabel = actulPayLabel;
    [self addSubview:actulPayLabel];
    [actulPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
