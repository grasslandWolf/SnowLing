//
//  OrderIntegralTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "OrderIntegralTableViewCell.h"

@implementation OrderIntegralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.payBtn = [[UIButton alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.IntegralTF = [[UITextField alloc] init];
        self.repayLabel = [[UILabel alloc] init];
        self.remainLabel = [[UILabel alloc] init];
        [self setUp];
    }
    return self;
}
-(void)setUp {

    UIButton * payBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = COLOR_CLEAR;
    payBtn.layer.cornerRadius = 7.5f;
    payBtn.layer.borderWidth = 0.5f;
    payBtn.layer.borderColor = COLOR_141.CGColor;
    payBtn.layer.masksToBounds = YES;
    [payBtn addTarget:self action:@selector(useIntegral:) forControlEvents:UIControlEventTouchUpInside];
    self.payBtn = payBtn;
    [self addSubview:payBtn];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(13);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textColor = COLOR_50;
    titleLabel.text = @"使用积分";
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(payBtn.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel * remainLabel = [[UILabel alloc] init];
    remainLabel.textAlignment = NSTextAlignmentLeft;
    remainLabel.font = [UIFont systemFontOfSize:11.0f];
    remainLabel.textColor = COLOR_174;
    remainLabel.text = @"剩余积分：22300  可抵￥223";
    self.remainLabel = remainLabel;
    [self addSubview:remainLabel];
    CGFloat width = SCREEN_WIDH - 106;
    [remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.top.equalTo(self.mas_top).offset(12);
        make.width.equalTo(@(width));
        make.height.equalTo(@15);
    }];
    
    UITextField * IntegralTF = [[UITextField alloc] init];
    IntegralTF.layer.borderColor = COLOR_222.CGColor;
    IntegralTF.layer.borderWidth = 0.5;
    IntegralTF.textColor = COLOR_174;
    IntegralTF.textAlignment = NSTextAlignmentLeft;
    IntegralTF.font = [UIFont systemFontOfSize:14.0];
    IntegralTF.placeholder = @"请输入抵用积分数";
    IntegralTF.hidden = YES;
    IntegralTF.delegate = self;
    IntegralTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    IntegralTF.keyboardType = UIKeyboardTypeNumberPad;
    self.IntegralTF = IntegralTF;
    [self addSubview:IntegralTF];
    
    [IntegralTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(40);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    
    UILabel * repayLabel = [[UILabel alloc] init];
    repayLabel.textAlignment = NSTextAlignmentRight;
    repayLabel.font = [UIFont systemFontOfSize:14.0f];
    repayLabel.textColor = COLOR_50;
    repayLabel.text = @"抵:￥15100";
    repayLabel.hidden = YES;
    self.repayLabel = repayLabel;
    [self addSubview:repayLabel];
    [repayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.mas_top).offset(40);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    

}

-(void)useIntegral:(UIButton *)sender {

    self.btnClick();
}

#pragma mark  UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {

    NSString * name = textField.text;
    if ([name integerValue] > 1000) {
        name = @"";
        [SLProressHUD showErrorMessage:@"请输入正确的积分" afterDelay:2.0];
        textField.text = @"";
        self.repayLabel.text = @"抵:0.00";
    } else {
        float number = [name integerValue]/100.0;
        NSString * title = [NSString stringWithFormat:@"抵:%.2f",number];
        self.repayLabel.text = title;
    }
  
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationIntegralChange object:name];


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
