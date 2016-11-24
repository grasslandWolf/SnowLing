//
//  SetUpViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "SetUpViewController.h"

#import "LoginViewController.h"

#import "AdressViewController.h"

#import "PersonDataViewController.h" // 个人信息

@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation SetUpViewController

-(NSMutableArray *)dataArray {

    if (!_dataArray) {
        
        NSArray *loginArr = @[@"个人资料",@"收货地址"];
        NSArray * accountArr = @[@"修改手机号",@"修改密码"];
        NSArray * orderArr = @[@"清除缓存"];
        NSArray * feedbackArr = @[@"反馈",@"关于买家秀"];
        _dataArray = [NSMutableArray arrayWithObjects:loginArr,accountArr,orderArr,feedbackArr, nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    [self setUp];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)setUp {

    [self configureTableViewAndFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.BaseTableView.delegate = self;
    self.BaseTableView.dataSource = self;
    self.BaseTableView.backgroundColor = [UIColor lightGrayColor];
    
    UIView * footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 100)];
    footerView.backgroundColor = [UIColor cyanColor];
    
    // 返回
    UIButton * loginBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 10.0;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginBtn];
    if ([SLTool isLogin]) {
        
        [loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];

    } else {
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];

    
    }
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(loginBtn.superview).offset(30);
        make.left.equalTo(loginBtn.superview).offset(15);
        make.right.equalTo(loginBtn.superview).offset(-15);
        make.height.equalTo(@40);
    }];
    
    self.BaseTableView.tableFooterView = footerView;

}

-(void)login:(UIButton *)btn {

    if ([SLTool isLogin]) {
        
        
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];

        
    } else {
    
        LoginViewController * loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:^{
            
        }];
    
    }
    
}
#pragma mark UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    NSArray * arr = self.dataArray[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

static NSString * identifier = @"Identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString * name = self.dataArray[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = name;
    cell.detailTextLabel.text = @"123456";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PersonDataViewController * adressVC = [[PersonDataViewController alloc] init];
            [self.navigationController pushViewController:adressVC animated:YES];
            
        } else if (indexPath.row == 1) {
            AdressViewController * adressVC = [[AdressViewController alloc] init];
            [self.navigationController pushViewController:adressVC animated:YES];
        }
    }
}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 10)];
//    headView.backgroundColor = [UIColor yellowColor];
//    tableView.tableHeaderView = headView;
//    return headView;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView * footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 50)];
//    footerView.backgroundColor = [UIColor cyanColor];
//    tableView.tableFooterView = footerView;
//    return footerView;
//
//}
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
