//
//  AddAdressTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AddAdressTableViewCell.h"

@implementation AddAdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleTF = [[UITextField alloc] init];
        self.locationbtn = [[UIButton alloc] init];
        [self setUp];
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
        
        
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UITextField * titleTF = [[UITextField alloc] init];
    titleTF.textColor = COLOR_50;
    titleTF.textAlignment = NSTextAlignmentLeft;
    titleTF.font = [UIFont systemFontOfSize:14.0];
   // titleTF.delegate = self;
    titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    titleTF.keyboardType = UIKeyboardTypeDefault;
    self.titleTF = titleTF;
    [self addSubview:titleTF];
    
    [titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(86);
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right).offset(-29);
        make.height.equalTo(@20);
    }];
    
    UIButton * locationbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    locationbtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [locationbtn setTitle:@"定位" forState:UIControlStateNormal];
    [locationbtn setImage:[UIImage imageNamed:@"position"] forState:UIControlStateNormal];
    self.locationbtn = locationbtn;
    [locationbtn setTitleColor:COLOR_Theme forState:UIControlStateNormal];
    [locationbtn addTarget:self action:@selector(startLocation:) forControlEvents:UIControlEventTouchUpInside];
    locationbtn.hidden = YES;
    [self addSubview:locationbtn];
    [locationbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    

}
-(void)startLocation:(UIButton *)sender {

    self.btnClick();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
