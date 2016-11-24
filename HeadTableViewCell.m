//
//  HeadTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/7.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "HeadTableViewCell.h"

@implementation HeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.colorView = [[UIView alloc] init];
        [self setUp];
    }
    return self;
}

-(void)setUp {

    NSArray * array = [NSArray arrayWithObjects:@"排序",@"分类",@"筛选", nil];
    for (int i = 0; i < 3; i++) {
        
        // 返回
        CGFloat width = SCREEN_WIDH/3;
        UIButton * titlebtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        titlebtn.frame = CGRectMake(width * i, 10, width, 30);
//        titlebtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
        [titlebtn setTitle:array[i] forState:UIControlStateNormal];
        [titlebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titlebtn.tag = 123 + i;
        [titlebtn addTarget:self action:@selector(reloadMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titlebtn];
        
    }
    
}
-(void)reloadMessage:(UIButton *)btn {
    
      if (self.lastBtn == nil){
        btn.selected = YES;
        self.lastBtn = btn;
    }
    else  if (self.lastBtn !=nil &&self.lastBtn == btn){
        btn.selected = YES;
    } else if (self.lastBtn!= btn && self.lastBtn!=nil){
        self.lastBtn.selected = NO;
        btn.selected = YES;
        self.lastBtn = btn;
    }
   
    
    if ([self.delegate respondsToSelector:@selector(reloadMessage:)]) {
        [self.delegate reloadMessage:btn.tag];
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
