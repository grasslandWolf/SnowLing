//
//  AddUserViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/10.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AddUserViewController.h"

@interface AddUserViewController ()



@end

@implementation AddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACK;
    
    if (self.type == 5) {
        self.title = @"提现账户";
    } else {
    
        self.title = @"提现密码";
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setUp];
}
-(void)setUp {

    UIView * mainView = [[UIView alloc] init];
    mainView.layer.borderColor = COLOR_141.CGColor;
    mainView.layer.masksToBounds = YES;
    mainView.layer.borderWidth = 0.5;
    mainView.layer.cornerRadius = 5.0;
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(mainView.superview).offset(15);
        make.right.equalTo(mainView.superview).offset(-15);
        make.height.equalTo(@160);
        
    }];
    
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = COLOR_174;
    [mainView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(10);
        make.left.equalTo(mainView.mas_left).offset(104);
        make.height.equalTo(@20);
        make.width.equalTo(@0.5);
        
    }];
    
    UIView * middleView = [[UIView alloc] init];
    middleView.backgroundColor = COLOR_174;
    [mainView addSubview:middleView];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(50);
        make.left.equalTo(mainView.mas_left).offset(104);
        make.height.equalTo(@20);
        make.width.equalTo(@0.5);
        
    }];
    
    UIView * thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = COLOR_174;
    [mainView addSubview:thirdView];
    
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(90);
        make.right.equalTo(mainView.mas_right).offset(-100);
        make.height.equalTo(@20);
        make.width.equalTo(@0.5);
        
    }];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_174;
    [mainView addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mainView.mas_bottom).offset(-10);
        make.left.equalTo(mainView.mas_left).offset(104);
        make.height.equalTo(@20);
        make.width.equalTo(@0.5);
        
    }];
    
    UIView * topColorView = [[UIView alloc] init];
    topColorView.backgroundColor = COLOR_174;
    [mainView addSubview:topColorView];
    
    [topColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(40);
        make.left.and.right.equalTo(mainView);
        make.height.equalTo(@0.5);
        
    }];
    UIView * middleColorView = [[UIView alloc] init];
    middleColorView.backgroundColor = COLOR_174;
    [mainView addSubview:middleColorView];
    
    [middleColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(80);
        make.left.and.right.equalTo(mainView);
        make.height.equalTo(@0.5);
        
    }];
    UIView * bottomColorView = [[UIView alloc] init];
    bottomColorView.backgroundColor = COLOR_174;
    [mainView addSubview:bottomColorView];
    
    [bottomColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(120);
        make.left.and.right.equalTo(mainView);
        make.height.equalTo(@0.5);
        
    }];
    
    UILabel * firstLabel = [[UILabel alloc] init];
    firstLabel.textAlignment = NSTextAlignmentRight;
    firstLabel.font = [UIFont systemFontOfSize:14.0f];
    firstLabel.textColor = COLOR_141;
    [mainView addSubview:firstLabel];
    
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(topView.mas_left).offset(-10);
        make.top.equalTo(mainView.mas_top).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@90);
    }];
    
    
    UILabel * secondLabel = [[UILabel alloc] init];
    secondLabel.textAlignment = NSTextAlignmentRight;
    secondLabel.font = [UIFont systemFontOfSize:14.0f];
    secondLabel.textColor = COLOR_141;
    [mainView addSubview:secondLabel];
    
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(middleView.mas_left).offset(-10);
        make.top.equalTo(mainView.mas_top).offset(50);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    UILabel * threeLabel = [[UILabel alloc] init];
    threeLabel.textAlignment = NSTextAlignmentRight;
    threeLabel.font = [UIFont systemFontOfSize:14.0f];
    threeLabel.textColor = COLOR_141;
    [mainView addSubview:threeLabel];
    
    [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(bottomView.mas_left).offset(-10);
        make.top.equalTo(mainView.mas_top).offset(130);
        make.left.equalTo(mainView.mas_left).offset(10);
        make.height.equalTo(@20);
    }];
    
    
    if (self.type == 5) {
        
        firstLabel.text = @"支付宝账户名";
        secondLabel.text = @"支付宝账户";
        threeLabel.text = @"验证码";
        
    } else if (self.type == 2) {
    
        firstLabel.text = @"提现密码";
        secondLabel.text = @"确认提现密码";
        threeLabel.text = @"验证码";
    }
 
    // 获取验证码
    UIButton * codeBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitleColor:COLOR_50 forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(code:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:codeBtn];
    
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_top).offset(90);
        make.width.equalTo(@80);
        make.right.equalTo(mainView.mas_right).offset(-10);
        make.height.equalTo(@20);

    }];
    
    
}
-(void)code:(UIButton*)sender {


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
