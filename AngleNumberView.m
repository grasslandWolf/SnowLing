//
//  AngleNumberView.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/3.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AngleNumberView.h"

@implementation AngleNumberView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame {
    
    CGRect Myframe = CGRectMake(0, 0, 40, 40);
   self =  [super initWithFrame:Myframe];
    if (self) {
        
        [self addSubview:self.carBtn];
    }
    return self;
}
-(void)setUp {


}


-(UIButton *)carBtn {

    if (!_carBtn) {
        
        _carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _carBtn.frame = CGRectMake(0, 8, 32, 32);
        [_carBtn setTitleColor:COLOR_Theme forState:UIControlStateNormal];
        _carBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_carBtn addTarget:self action:@selector(shopCarButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _carBtn;
}

-(UILabel *)numberLabel {

    if (!_numberLabel) {
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 5, 16, 16)];
        
        _numberLabel.backgroundColor = [UIColor redColor];
        
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        _numberLabel.textColor = [UIColor whiteColor];
        
        _numberLabel.layer.cornerRadius = 8;
        
        _numberLabel.font = [UIFont systemFontOfSize:12];
        
        _numberLabel.layer.masksToBounds = YES;
        
        [self addSubview:_numberLabel];
    }
    return _numberLabel;
}


// 为购物车设置角标内数值

- (void)setShopCarCount:(NSString *)count{
    
    if ([count integerValue] == 0) {
        
        if (_numberLabel) {
            
            [_numberLabel removeFromSuperview];
            
            _numberLabel = nil;
            
        }
        
        return;
        
    }
    
    if ([count integerValue] > 9) {
        
        self.numberLabel.text = @"9+";
        
    }else{
        
        self.numberLabel.text = count;
        
    }
    
   // [selfshakeView:_countLabel];
    
    
    
}




-(void)shopCarButtonAction {

    [self.delegate getNumber];
}
@end
