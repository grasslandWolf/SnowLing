//
//  OrderPayViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/12.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "OrderPayViewController.h"

#import "OrderPayTableViewCell.h"

#import "OrderPayCell.h"

#import "OrderIntegralTableViewCell.h"

@interface OrderPayViewController ()<UITableViewDelegate,UITableViewDataSource,BeeCloudDelegate>

@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单支付";
    self.view.backgroundColor = COLOR_BACK;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.index = -5;
    self.isSelected = NO;
    [self setUp];
    [BeeCloud setBeeCloudDelegate:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:NotificationIntegralChange object:nil];
}
-(void)changeName:(NSNotification *)notification {

    NSString * name = notification.object;
    float number = [name integerValue]/100.0;
    float Num = 185 - number;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    OrderPayCell * cell = (OrderPayCell *)[self.BaseTableView cellForRowAtIndexPath:indexPath];
    cell.actulPayLabel.text = [NSString stringWithFormat:@"%.2f",Num];
}
-(void)setUp {

    [self configureTableViewAndFrame:CGRectMake(0, 10, SCREEN_WIDH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.BaseTableView.backgroundColor = [UIColor clearColor];
    self.BaseTableView.delegate = self;
    self.BaseTableView.dataSource = self;
    self.BaseTableView.scrollEnabled = NO;
    
    UIButton * confirmBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    confirmBtn.backgroundColor = COLOR_Theme;
    [confirmBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [confirmBtn addTarget:self action:@selector(confirmPay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(confirmBtn.superview);
        make.bottom.equalTo(confirmBtn.superview);
        make.height.equalTo(@50);
        
    }];
    
}
-(void)confirmPay:(UIButton *)sender {

    if (self.index == -5) {
        [SLProressHUD showErrorMessage:@"请至少选择一种支付方式" afterDelay:2.0];
        return;
    }
    if (self.index == 0) {
        
    } else {
        PayChannel channel;
        if (self.index ==1) {
            channel = PayChannelAliApp;
            
        } else if (self.index ==2) {
            
            channel = PayChannelWxApp;
        }
        
        [self doPay:channel];
    
    }

}

- (void)doPay:(PayChannel)channel {
    
    NSString *billno = [self genBillNo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    /**
     按住键盘上的option键，点击参数名称，可以查看参数说明
     **/
    BCPayReq *payReq = [[BCPayReq alloc] init];
    payReq.channel = channel; //支付渠道
    payReq.title = @"online pay"; //订单标题
    payReq.totalFee = @"10"; //订单价格
    payReq.billNo = billno; //商户自定义订单号
    payReq.scheme = @"payDemo"; //URL Scheme,在Info.plist中配置; 支付宝必有参数
    payReq.billTimeOut = 300; //订单超时时间
    payReq.cardType = 0; // 0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
    payReq.viewController = self; //银联支付和Sandbox环境必填
    payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
    [BeeCloud sendBCReq:payReq];
}
#pragma mark - 生成订单号
- (NSString *)genBillNo {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}
#pragma mark - BCPay回调

- (void)onBeeCloudResp:(BCBaseResp *)resp {

    switch (resp.type) {
        case BCObjsTypePayResp:
        {
            // 支付请求响应
            BCPayResp *tempResp = (BCPayResp *)resp;
            if (tempResp.resultCode == 0) {
              
                    //微信、支付宝、银联支付成功
                    [SLProressHUD showSuccessMessage:resp.resultMsg afterDelay:2.0 ];
         
            } else {
                //支付取消或者支付失败
                [SLProressHUD showErrorMessage:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail] afterDelay:2.0];
            }
        }

        default:
            break;
    }
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * identifer = @"identifer";
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            
            OrderIntegralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (!cell) {
                cell = [[OrderIntegralTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            }
            cell.btnClick = ^{
                [self changeCellHeight];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            OrderPayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            if (!cell) {
                cell = [[OrderPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            }
            if (indexPath.row == 0) {
                cell.securityLabel.text = @"担保金";
                cell.actulPayLabel.text = @"￥200.00";
            } else {
                cell.securityLabel.text = @"实际支付";
                cell.actulPayLabel.textColor = COLOR_Theme;
                cell.actulPayLabel.text =@"185.0";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    } else {
    
        OrderPayTableViewCell * cell = (OrderPayTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell = [[OrderPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        NSArray * titleArray = [NSArray arrayWithObjects:@"账户余额",@"支付宝",@"微信支付", nil];
        NSArray * images = [NSArray arrayWithObjects:@"zhanghuyue",@"zhifubao",@"weixinzhifu", nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headImageView.image = [UIImage imageNamed:images[indexPath.row]];
        cell.titleLabel.text = titleArray[indexPath.row];
        return cell;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 40)];
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 10)];
    headView.backgroundColor = [UIColor whiteColor];
    topView.backgroundColor = [UIColor clearColor];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textColor = COLOR_141;
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(headView.mas_left).offset(15);
        make.top.equalTo(headView.mas_top).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    if (section == 1) {
        
        titleLabel.text = @"选择支付方式";
    }
    [headView addSubview:topView];
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 40;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            if (!self.isSelected) {
                return 40;
            } else {
                return 70;
            }
        } else {
            return 40;
        }
    } else {
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        OrderPayTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.payBtn.backgroundColor = COLOR_Theme;
        [cell.payBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        if (indexPath.row == 0) {
            self.paytype = 1;
        } else {
            self.paytype = 2;
        }
        self.index = indexPath.row;
    }

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        
        OrderPayTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.payBtn.backgroundColor = COLOR_CLEAR;
        cell.payBtn.layer.cornerRadius = 7.5f;
        cell.payBtn.layer.borderWidth = 0.5f;
        cell.payBtn.layer.borderColor = COLOR_141.CGColor;
        cell.payBtn.layer.masksToBounds = YES;

    }
}
// 改变cell的高度
-(void)changeCellHeight {


    NSIndexPath * indexpath = [NSIndexPath indexPathForRow:1 inSection:0];
    self.isSelected = !self.isSelected;
    OrderIntegralTableViewCell * cell = (OrderIntegralTableViewCell*)[self.BaseTableView cellForRowAtIndexPath:indexpath];
    if (self.isSelected) {
        cell.payBtn.backgroundColor = COLOR_Theme;
        [cell.payBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        cell.IntegralTF.hidden = NO;
        cell.repayLabel.hidden = NO;
        
    } else {
        cell.payBtn.backgroundColor = COLOR_CLEAR;
        cell.payBtn.layer.cornerRadius = 7.5f;
        cell.payBtn.layer.borderWidth = 0.5f;
        cell.payBtn.layer.borderColor = COLOR_141.CGColor;
        cell.payBtn.layer.masksToBounds = YES;
        cell.IntegralTF.hidden = YES;
        cell.repayLabel.hidden = YES;
        cell.IntegralTF.text = @"";
        cell.repayLabel.text = @"抵:0.00";
        

    }
    [self.BaseTableView reloadData];
    
//    if (!self.isSelected) {
//        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//        OrderPayCell * cell = (OrderPayCell *)[self.BaseTableView cellForRowAtIndexPath:indexPath];
//        cell.actulPayLabel.text = @"200.00";
//    }
    
    
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
