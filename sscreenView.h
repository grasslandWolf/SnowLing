//
//  sscreenView.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/31.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol sscreenViewDelegate <NSObject>
//
//-(void)click;
//
//@end

typedef void (^VoidBlock)(NSDictionary *);

@interface sscreenView : UIView <UITextFieldDelegate>

@property (nonatomic,strong) UILabel * levelLabel;

@property (nonatomic,strong) UILabel * heightLabel;

@property (nonatomic,strong) UILabel * weightLabel;

@property (nonatomic,strong) UILabel * ageLabel;

@property (nonatomic,strong) UILabel * sexLabel;

@property (nonatomic,strong) UILabel * videoLabel;

@property (nonatomic,copy) VoidBlock voidBlock ;

//@property(nonatomic,assign) id <sscreenViewDelegate> sscreendelegate;




@end
