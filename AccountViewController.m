//
//  AccountViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/10.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AccountViewController.h"

#import "AddUserViewController.h"

@interface AccountViewController ()

@property (nonatomic,strong) UITableView * AccounttableView;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现";
    self.view.backgroundColor = COLOR_BACK;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUp];
    
}
-(void)setUp {

    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.top.equalTo(topView.superview).offset(15);
        make.right.equalTo(topView.superview).offset(-15);
        make.height.equalTo(@200);
    }];
    
    UIButton * withdrawalbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    withdrawalbtn.backgroundColor = COLOR_Theme;
    withdrawalbtn.layer.masksToBounds = YES;
    withdrawalbtn.layer.cornerRadius = 5.0f;
    [withdrawalbtn setTitle:@"提现" forState:UIControlStateNormal];
    [withdrawalbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    withdrawalbtn.tag = 1122;
    [withdrawalbtn addTarget:self action:@selector(Cashwithdrawal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:withdrawalbtn];
    
    [withdrawalbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(topView.mas_bottom).offset(47);
        make.left.equalTo(withdrawalbtn.superview).offset(15);
        make.right.equalTo(withdrawalbtn.superview).offset(-15);
        make.height.equalTo(@40);

    }];
    
    UILabel * warnLabel = [[UILabel alloc] init];
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"最低提现金额  ¥100.00";
    warnLabel.textColor  = COLOR_141;
    warnLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:warnLabel];
    
    [warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(withdrawalbtn.mas_bottom).offset(15);
        make.right.equalTo(@200);
        make.height.equalTo(@17);
    }];
    
    UIView * accountView = [[UIView alloc] init];
    accountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:accountView];
    
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(warnLabel.mas_bottom).offset(15);
        make.left.and.right.equalTo(accountView.superview);
        make.height.equalTo(@100);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.text = @"提现账户";
    titleLabel.textColor = COLOR_141;
    [accountView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(accountView.mas_left).offset(15);
        make.top.equalTo(accountView.mas_top).offset(15);
        make.right.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel * passwordLabel = [[UILabel alloc] init];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.font = [UIFont systemFontOfSize:14.0f];
    passwordLabel.text = @"提现密码";
    passwordLabel.textColor = COLOR_141;
    [accountView addSubview:passwordLabel];
    
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(accountView.mas_left).offset(15);
        make.bottom.equalTo(accountView.mas_bottom).offset(-15);
        make.right.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIView * colorView = [[UIView alloc] init];
    colorView.backgroundColor = COLOR_141;
    [accountView addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.and.right.equalTo(accountView);
        make.top.equalTo(accountView.mas_top).offset(49.5);
        make.height.equalTo(@0.5);
    }];
    
    
    UIButton * addAccountBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    addAccountBtn.frame = CGRectMake(SCREEN_WIDH- 100-35, 15, 100, 20);
    addAccountBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [addAccountBtn setTitle:@"添加账户" forState:UIControlStateNormal];
    [addAccountBtn setTitleColor:COLOR_Theme forState:UIControlStateNormal];
    addAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    UIFont * font = [UIFont systemFontOfSize:14.0];
    CGFloat labelWidth = [addAccountBtn.titleLabel.text sizeWithAttributes:@{@"NSFontAttributeName" :font}].width;
    
    [addAccountBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [addAccountBtn setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth + 40, 0,0)];
    UIImage * image = [UIImage imageNamed:@"more"];
    [addAccountBtn setImage:image forState:UIControlStateNormal];
    [addAccountBtn addTarget:self action:@selector(Cashwithdrawal:) forControlEvents:UIControlEventTouchUpInside];
    addAccountBtn.tag = 1123;
    [accountView addSubview:addAccountBtn];

    
    UIButton * AccountPasswordBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    AccountPasswordBtn.frame = CGRectMake(SCREEN_WIDH - 100-35, 65, 100, 20);
    AccountPasswordBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [AccountPasswordBtn setTitle:@"设置" forState:UIControlStateNormal];
    [AccountPasswordBtn setTitleColor:COLOR_141 forState:UIControlStateNormal];
    AccountPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    UIFont * font1 = [UIFont systemFontOfSize:14.0];
    CGFloat labelWidth1 = [AccountPasswordBtn.titleLabel.text sizeWithAttributes:@{@"NSFontAttributeName" :font1}].width;
    [AccountPasswordBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [AccountPasswordBtn setImageEdgeInsets:UIEdgeInsetsMake(0,labelWidth1 +60, 0, 0)];
    [AccountPasswordBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [AccountPasswordBtn addTarget:self action:@selector(Cashwithdrawal:) forControlEvents:UIControlEventTouchUpInside];
    AccountPasswordBtn.tag = 1124;
    [accountView addSubview:AccountPasswordBtn];
 
 
}

// 提现
-(void)Cashwithdrawal:(UIButton*)sender {

    switch (sender.tag) {
        case 1122:
            
            break;
        case 1123:
        {
            AddUserViewController * addVC = [[AddUserViewController alloc] init];
            addVC.type = 5;
            [self.navigationController pushViewController:addVC animated:YES];
        }
            break;
        case 1124:
        {
            AddUserViewController * addVC = [[AddUserViewController alloc] init];
            addVC.type = 2;
            [self.navigationController pushViewController:addVC animated:YES];
        
        }
            
            break;
            
        default:
            break;
    }

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
