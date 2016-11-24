//
//  TaskGroupCollectionViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/27.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "TaskGroupCollectionViewCell.h"

@implementation TaskGroupCollectionViewCell

-(id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUp];
        
    }
    return self;
}

-(void)setUp {

    UILabel * label = [[UILabel alloc] init];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = label;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.and.bottom.equalTo(self);
    }];

}
@end
