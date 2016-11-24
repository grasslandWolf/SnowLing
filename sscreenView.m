//
//  sscreenView.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/31.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "sscreenView.h"

@implementation sscreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {


    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp {

    
    UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30,55, 15)];
    levelLabel.backgroundColor = COLOR_CLEAR;
    levelLabel.font = [UIFont boldSystemFontOfSize:11];
    levelLabel.textColor = [UIColor blackColor];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.text = @"等级要求:";
    [self addSubview:levelLabel];
    
    UILabel * sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60,33, 15)];
    sexLabel.backgroundColor = COLOR_CLEAR;
    sexLabel.font = [UIFont boldSystemFontOfSize:11];
    sexLabel.textColor = [UIColor blackColor];
    sexLabel.textAlignment = NSTextAlignmentCenter;
    sexLabel.text = @"性别:";
    [self addSubview:sexLabel];
    
    UILabel * videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 90,55, 15)];
    videoLabel.backgroundColor = COLOR_CLEAR;
    videoLabel.font = [UIFont boldSystemFontOfSize:11];
    videoLabel.textColor = [UIColor blackColor];
    videoLabel.textAlignment = NSTextAlignmentCenter;
    videoLabel.text = @"视频认证:";
    [self addSubview:videoLabel];
    
    
    UILabel * heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 30,33, 15)];
    heightLabel.backgroundColor = COLOR_CLEAR;
    heightLabel.font = [UIFont boldSystemFontOfSize:11];
    heightLabel.textColor = [UIColor blackColor];
    heightLabel.textAlignment = NSTextAlignmentCenter;
    heightLabel.text = @"身高:";
    [self addSubview:heightLabel];
    
    UILabel * weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 60,33, 15)];
    weightLabel.backgroundColor = COLOR_CLEAR;
    weightLabel.font = [UIFont boldSystemFontOfSize:11];
    weightLabel.textColor = [UIColor blackColor];
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.text = @"体重:";
    [self addSubview:weightLabel];
    
    UILabel * ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(200,90,33, 15)];
    ageLabel.backgroundColor = COLOR_CLEAR;
    ageLabel.font = [UIFont boldSystemFontOfSize:11];
    ageLabel.textColor = [UIColor blackColor];
    ageLabel.textAlignment = NSTextAlignmentCenter;
    ageLabel.text = @"年龄:";
    [self addSubview:ageLabel];
    
    
    UIButton * recordbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    recordbtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    CGFloat x = [UIScreen mainScreen].bounds.size.width;
    
    recordbtn.frame = CGRectMake((x-140)/2, 125, 140, 27);
    recordbtn.layer.masksToBounds = YES;
    recordbtn.layer.cornerRadius = 10.0;
    [recordbtn setTitle:@"确定" forState:UIControlStateNormal];
    [recordbtn addTarget:self action:@selector(determine) forControlEvents:UIControlEventTouchUpInside];
    [recordbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:recordbtn];
    
    UITextField * heightMinTF = [[UITextField alloc] init];
    heightMinTF.borderStyle = UITextBorderStyleLine;
    heightMinTF.delegate = self;
    heightMinTF.keyboardType = UIKeyboardTypeNumberPad;
    heightMinTF.frame = CGRectMake(240, 30, 40, 15);
    [self addSubview:heightMinTF];
    
    UITextField * heightMaxTF = [[UITextField alloc] init];
    heightMaxTF.borderStyle = UITextBorderStyleLine;
    heightMaxTF.delegate = self;
    heightMaxTF.keyboardType = UIKeyboardTypeNumberPad;
    heightMaxTF.frame = CGRectMake(296, 30, 40, 15);
    [self addSubview:heightMaxTF];
    
    
    UITextField * weightMinTF = [[UITextField alloc] init];
    weightMinTF.borderStyle = UITextBorderStyleLine;
    weightMinTF.userInteractionEnabled = YES;
    weightMinTF.delegate = self;
    weightMinTF.keyboardType = UIKeyboardTypeNumberPad;
    weightMinTF.frame = CGRectMake(240, 60, 40, 15);
    [self addSubview:weightMinTF];
    
    UITextField * weightMaxTF = [[UITextField alloc] init];
    weightMaxTF.borderStyle = UITextBorderStyleLine;
    weightMaxTF.userInteractionEnabled = YES;
    weightMaxTF.delegate = self;
    weightMaxTF.keyboardType = UIKeyboardTypeNumberPad;
    weightMaxTF.frame = CGRectMake(296, 60, 40, 15);
    [self addSubview:weightMaxTF];
    
    
    UITextField * ageMinTF = [[UITextField alloc] init];
    ageMinTF.borderStyle = UITextBorderStyleLine;
    ageMinTF.userInteractionEnabled = YES;
    ageMinTF.delegate = self;
    ageMinTF.keyboardType = UIKeyboardTypeNumberPad;
    ageMinTF.frame = CGRectMake(240, 90, 40, 15);
    [self addSubview:ageMinTF];
    
    
    UITextField * ageMaxTF = [[UITextField alloc] init];
    ageMaxTF.borderStyle = UITextBorderStyleLine;
    ageMaxTF.userInteractionEnabled = YES;
    ageMaxTF.delegate = self;
    ageMaxTF.keyboardType = UIKeyboardTypeNumberPad;
    ageMaxTF.frame = CGRectMake(296, 90, 40, 15);
    ageMaxTF.font = [UIFont systemFontOfSize:11];
    [ageMaxTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:ageMaxTF];

    

}
-(void)determine {

    NSDictionary * dict = @{@"":@"minHeight",
                            @"":@"maxHeight",
                            @"":@"minAge",
                            @"":@"maxAge",
                            @"":@"minWeight",
                            @"":@"maxWeight",
                            @"":@"sex",
                            @"":@"level",
                            @"":@"video_auth",
                            };
    

    self.voidBlock(dict);
}



- (void)textFieldDidChange:(UITextField *)textField
{
    
        if (textField.text.length > 3) {
            textField.text = [textField.text substringToIndex:3];
        }
    
}

@end
