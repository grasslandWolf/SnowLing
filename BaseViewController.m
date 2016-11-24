//
//  BaseViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseViewController.h"

#import "HOMEViewController.h"
#import "TaskViewController.h"
#import "CarViewController.h"
#import "MeViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(instancetype)init {

    self = [super init];
    if (self) {
        if (![self shouldHandleTab]) {
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}

- (BOOL)shouldHandleTab {
    
    return [self isEqualWithFirstClass:[self class] secondClass:[HOMEViewController class]] ||
    [self isEqualWithFirstClass:[self class] secondClass:[TaskViewController class]] ||
    [self isEqualWithFirstClass:[self class] secondClass:[CarViewController class]] ||
    [self isEqualWithFirstClass:[self class] secondClass:[MeViewController class]];
}
- (BOOL)isEqualWithFirstClass:(Class)class1 secondClass:(Class)class2
{
    return [NSStringFromClass(class1) isEqualToString:NSStringFromClass(class2)];
}

-(void)initTitleView:(NSString*)title {

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDH/2-100, 35)];
    [titleLabel setTextColor:COLOR_50];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:18]];
    [titleLabel setText:title];
    self.navigationItem.titleView = titleLabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
