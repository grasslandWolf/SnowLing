//
//  MeTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "MeTableViewCell.h"

@implementation MeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp {

    
    UIImageView * headImageView = [[UIImageView alloc] init];
    self.headImageView = headImageView;
    headImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:headImageView];
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(headImageView.superview).offset(10);
        make.top.equalTo(headImageView.superview).offset(10);
        make.width.and.equalTo(@24);
    }];

    UILabel * headLabel = [[UILabel alloc] init];
    headLabel.textAlignment = NSTextAlignmentLeft;
    headLabel.font = [UIFont systemFontOfSize:16.0f];
    self.headLabel = headLabel;
    [self addSubview:headLabel];
    
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(headImageView.mas_right).offset(20);
        make.top.equalTo(headLabel.superview).offset(12);
        make.right.equalTo(headLabel.superview).offset(20);
        make.height.equalTo(@20);
    }];
    
    UIView * colorView = [[UIView alloc] init];
    colorView.backgroundColor = CCPRGBColor(219, 219, 219);
    [self addSubview:colorView];
    
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(colorView.superview).offset(10);
        make.right.equalTo(colorView.superview);
        make.bottom.equalTo(colorView.superview).offset(-0.5);
        make.height.equalTo(@0.5);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
