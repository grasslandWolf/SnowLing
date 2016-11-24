//
//  LogisticsMessageTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/9.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "LogisticsMessageTableViewCell.h"

@implementation LogisticsMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.dataLabel = [[UILabel alloc] init];
        self.grayView = [[UILabel alloc] init];
        self.redImageView = [[UIImageView alloc] init];
        self.title = [[NSString alloc] init];
        
        
    }
    return self;

}
-(void)setUp {

    UIImageView * headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 15, 15)];
    self.redImageView = headImageView;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = 7.5;
    headImageView.backgroundColor = [UIColor redColor];
    [self addSubview:headImageView];
    
    UIView * grayView  = [[UIView alloc] initWithFrame:CGRectMake(18, 20, 8, 8)];
    self.grayView = grayView;
    grayView.layer.masksToBounds = YES;
    grayView.layer.cornerRadius = 4.0;
    grayView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:grayView];
    
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    titleLabel.text = self.title;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = COLOR_141;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    
    UIFont * font = [UIFont systemFontOfSize:12.0f];
    
    CGRect rect = [titleLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDH - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    static CGFloat width = 0;
    if (rect.size.height > 17) {
        width = 34;
    } else {
        width = 17;
    }
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(titleLabel.superview).offset(45);
        make.top.equalTo(titleLabel.superview).offset(15);
        make.right.equalTo(titleLabel.superview).offset(-15);
        make.height.equalTo(@(width));
    }];
    
   

    
    UILabel * dateLabel = [[UILabel alloc] init];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.font = [UIFont systemFontOfSize:12.0f];
    dateLabel.text = @"运单编号：   882987328350183181";
    self.dataLabel = dateLabel;
    dateLabel.textColor = COLOR_141;
    [self addSubview:dateLabel];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(dateLabel.superview).offset(45);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.right.equalTo(dateLabel.superview).offset(-15);
        make.height.equalTo(@15);
    }];

    
    

}

-(void)getTitle:(NSString *)title {

    self.title = title;
    self.titleLabel.text = self.title;
    
    [self setUp];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
