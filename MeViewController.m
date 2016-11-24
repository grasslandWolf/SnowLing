//
//  MeViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "MeViewController.h"

#import "MeTableViewCell.h"

#import "OrderViewController.h"

#import "SetUpViewController.h"

#import "FeedbackViewController.h"

#import "AboutViewController.h"

#import "AccountViewController.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation MeViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    int number = [CollectionAndLikeManager adressCount];
    [SLProressHUD showSuccessMessage:[NSString stringWithFormat:@"地址的数量是%d",number] afterDelay:2.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // self.navigationController.navigationBarHidden = YES;
    
   self.edgesForExtendedLayout = UIRectEdgeNone;
    
   // self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = COLOR_BACK;
    
    [self setUp];
   // [self.BaseTableView.mj_header endRefreshing];

    
}

-(void)setUp {
    
    [self configureTableViewAndFrame:CGRectMake(0,0,SCREEN_WIDH , SCREEN_HEIGHT ) style:UITableViewStylePlain];
    self.BaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}
-(NSMutableArray *)dataArray {


    if (!_dataArray) {
        
//        NSArray * loginArr = [NSArray arrayWithObjects:@"未登录", nil];
        
        NSArray *loginArr = @[@"未登录"];
        NSArray * accountArr = [NSArray arrayWithObjects:@"我的账户", nil];
        NSArray * orderArr = [NSArray arrayWithObjects:@"我的订单",@"联系人",@"服务商认证", nil];
        NSArray * feedbackArr = [NSArray arrayWithObjects:@"反馈",@"设置", nil];
        _dataArray = [NSMutableArray arrayWithObjects:loginArr,accountArr,orderArr,feedbackArr, nil];
    }
    return _dataArray;
}

#pragma mark  UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray * arr = self.dataArray[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray * mainArr = self.dataArray[indexPath.section];
    NSString * title = mainArr[indexPath.row];
    
    
    static NSString * identifer = @"identifer";
    if (indexPath.section == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.textLabel.text = title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
    
        MeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            
            cell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headLabel.text = title;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return 60;
        
    } else {
    
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {


    return 10;
}
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 10)];
//    tableView.tableFooterView = footerView;
//    return footerView;
//}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            
            
        }
            break;
        case 1:
        {
            AccountViewController * accVC = [[AccountViewController alloc] init];
            [self.navigationController pushViewController:accVC animated:YES];
        
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    OrderViewController * orderVC = [[OrderViewController alloc] init];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                    break;
                case 1:
                {
                    AboutViewController * orderVC = [[AboutViewController alloc] init];
                    [self.navigationController pushViewController:orderVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0 :
                {
                    FeedbackViewController * feedVC = [[FeedbackViewController alloc] init];
                    [self.navigationController pushViewController:feedVC animated:YES];
                
                }
                    
                    break;
                    
                case 1 :
                {
                    SetUpViewController * orderVC = [[SetUpViewController alloc] init];
                    [self.navigationController pushViewController:orderVC animated:YES];
                
                }
                    
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        default:
            break;
    }
    
   

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
